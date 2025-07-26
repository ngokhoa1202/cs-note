#design-pattern #software-engineering  #software-architecture #object-oriented-programming #behavioral-pattern  #solid #functional-programming  #java #caching 

- Also known as Snapshot, Token.
# Purpose
- Captures and externalizes an object's internal state so that the object can be later restored to its previous state.
# Application
- A snapshot of an object's state must be saved so that it can be restored to that state later.
- A direct interface to obtain the state would expose implementation details and break the object's encapsulation.
```Java title='Direct state exposure without encapsulation of Memento'
// BAD: Direct state exposure
class TextEditorMemento {
    public String content;           // Exposes internal representation
    public int cursorPosition;       // Reveals implementation details
    public HashMap<String, Object> settings; // Shows internal data structure
}

// External code can now:
memento.content = "hacked";         // Bypass validation
memento.settings.put("evil", hack); // Manipulate internals
```
# Components
- ![[Pasted image 20250711081135.png]]
- ![[Pasted image 20250711081020.png]]
## Memento
- Stores the internal state of the Originator object.
- Insulates that internal state from external access except the Originator. In fact, it have two interfaces: one interface for Caretaker and one interface for Originator.
	- The Caretaker only sees a ***narrow*** interface to the Memento; in other words, it can only pass the memento instance to other objects <mark class="hltr-yellow">without accessing the internal state</mark>.
	- The Originator, in contrast, sees a ***wider*** interface to the Memento because it <mark class="hltr-yellow">accesses the internal state inside Memento</mark> to to restore itself to the previous state.
## Originator
- Instantiates a memento encapsulating a snapshot of its current state.
- Exploits the Memento to restore its previous state.
## Caretaker
- Takes the responsibility for the <mark class="hltr-yellow">Memento's safekeeping</mark>.
- Never accesses the internal content of the Memento.
# Example
## Text editor history
- ![[Pasted image 20250718082836.png]]
- `record TextEditorMemento` is a Memento, which stores a state of a `TextEditor` .
```Java title='record TextEditorMemento is a memento'
record TextEditorMemento(String content, int cursorPosition, String fileName) {}
```
- `class TextEditor` is an originator, which resembles the task of a normal text editor. Whenever it calls the method `save`, it instantiates a new `TextEditorMemento` object and it is able to restore to a specific state via the `restore` method, which accepts a `TextEditorMemento`.

```Java title='class TextEditor is an originator'
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
class TextEditor {
  private String content;
  private int cursorPosition;
  private String fileName;

  public TextEditor(String fileName) {
    this.fileName = fileName;
    this.content = "";
    this.cursorPosition = 0;
  }

  // Business methods that modify state
  public void write(String text) {
    String beforeCursor = content.substring(0, cursorPosition);
    String afterCursor = content.substring(cursorPosition);
    content = beforeCursor + text + afterCursor;
    cursorPosition += text.length();
  }

  public void moveCursor(int position) {
    if (position >= 0 && position <= content.length()) {
      this.cursorPosition = position;
    }
  }


  // Create memento - saves current state
  public TextEditorMemento save() {
    return new TextEditorMemento(content, cursorPosition, fileName);
  }

  // Restore from memento
  public void restore(TextEditorMemento memento) {
    this.content = memento.content();
    this.cursorPosition = memento.cursorPosition();
    this.fileName = memento.fileName();
  }

  // Display current state
  public void display() {
    System.out.println("File: " + fileName);
    System.out.println("Content: " + content);
    System.out.println("Cursor Position: " + cursorPosition);
    System.out.println("---");
  }
}
```
- `class EditorHistory` a caretaker which stores the history of text editor states as a stack. Whenever a state is saved, it pushes the state to the history stack. When the originator `TextEditor` needs to restore to its previous state, the stack removes its top element and delegates the restoration logic to the `TextEditor`. 
```Java title='class EditorHistory is a caretaker'
import java.util.Stack;

class EditorHistory {
  private final Stack<TextEditorMemento> history;
  private final int maxHistorySize;

  public EditorHistory(int maxHistorySize) {
    this.history = new Stack<>();
    this.maxHistorySize = maxHistorySize;
  }

  public void saveState(TextEditor editor) {
    // Maintain maximum history size
    if (history.size() >= maxHistorySize) {
      history.remove(0); // Remove oldest state
    }
    history.push(editor.save());
    System.out.println("State saved. History size: " + history.size());
  }

  public boolean undo(TextEditor editor) {
    if (history.isEmpty()) {
      System.out.println("No previous states available for undo.");
      return false;
    }

    TextEditorMemento previousState = history.pop();
    editor.restore(previousState);
    System.out.println("Undo successful. History size: " + history.size());
    return true;
  }

  public int getHistorySize() {
    return history.size();
  }
}
```
- `class Main` is the Client class. It ordinarily makes the `EditorHistory` object to save a state of `TextEditor` Whenever the Client needs the Originator `TextEditor` to restore its previous state, it requests the Caretaker `EditorHistory` to undo by reusing the old data. 
```Java title='class Main is the driver class'
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class App {

  /** Program entry point. */
  public static void main(String[] args) {
    // Initialize components
    TextEditor editor = new TextEditor("document.txt");
    EditorHistory history = new EditorHistory(5);

    // Initial state
    System.out.println("=== Initial State ===");
    editor.display();

    // Make changes and save states
    System.out.println("=== Writing 'Hello World' ===");
    editor.write("Hello World");
    history.saveState(editor);
    editor.display();

    System.out.println("=== Moving cursor and adding text ===");
    editor.moveCursor(5);
    editor.write(" Beautiful");
    history.saveState(editor);
    editor.display();

    System.out.println("=== Changing filename ===");
    editor.setFileName("updated_document.txt");
    history.saveState(editor);
    editor.display();

    // Demonstrate undo functionality
    System.out.println("=== Performing Undo Operations ===");
    history.undo(editor);
    editor.display();

    history.undo(editor);
    editor.display();

    history.undo(editor);
    editor.display();

    // Attempt undo when no history available
    history.undo(editor);
  }
}

```
# Flowchart
- ![[Pasted image 20250718073655.png]]
- A caretaker requests a memento from an originator, holds it for a time, and passes it back to the originator if the originator needs to revert to an earlier state.
- Mementos are passive. Only the originator that instantiated a memento will assign or retrieve its state.
- ![[Pasted image 20250718074752.png]]
# Design
## Language support
- Mementos have two interfaces: a wide one for originators and a narrow one for other objects:
	- The narrow interface is declared public.
	- Hiding the narrow interface depends on the language.
## Storing incremental changes instead of absolute state in Memento
- When mementos is instantiated and passed back to their originator in <mark class="hltr-yellow">a predictable sequence</mark>, then Memento can save just the <mark class="hltr-yellow">incremental change </mark>to the originator's internal state <mark class="hltr-yellow">without storing the complete state of the Originator</mark>:
	- User makes change → Create memento.
	- User hits undo → Apply inverse operation.
	- User hits redo → Apply original operation again.
- An inverse operation rather than a full snapshot is stored to help the Originator recover in the future.
```Java title='Traditional memento'
// ============================================================================
// TRADITIONAL MEMENTO IMPLEMENTATION
// ============================================================================

// Traditional Memento - stores complete state
class TraditionalMemento {
    private final String content;
    private final int cursorPosition;
    private final Map<String, String> metadata;
    private final List<String> selectedText;
    
    public TraditionalMemento(String content, int cursorPosition, 
                            Map<String, String> metadata, List<String> selectedText) {
        this.content = new String(content); // Deep copy
        this.cursorPosition = cursorPosition;
        this.metadata = new HashMap<>(metadata); // Deep copy
        this.selectedText = new ArrayList<>(selectedText); // Deep copy
    }
    
    // Getters for restoration
    public String getContent() { return content; }
    public int getCursorPosition() { return cursorPosition; }
    public Map<String, String> getMetadata() { return new HashMap<>(metadata); }
    public List<String> getSelectedText() { return new ArrayList<>(selectedText); }
}
```

- Each memento type (`TextInsertionMemento`, `TextDeletionMemento`, `CursorMovementMemento`) stores only the specific change that occurred
```
```
```Java title='Incremental memento'
// ============================================================================
// INCREMENTAL MEMENTO IMPLEMENTATION
// ============================================================================

// Incremental Memento - stores only changes
abstract class IncrementalMemento {
    protected final long timestamp;
    
    protected IncrementalMemento() {
        this.timestamp = System.currentTimeMillis();
    }
    
    // Template method for applying/undoing changes
    public abstract void undo(TextEditor editor);
    public abstract void redo(TextEditor editor);
}


// Specific memento for text insertion
class TextInsertionMemento extends IncrementalMemento {
    private final int position;
    private final String insertedText;
    private final int oldCursorPosition;
    private final int newCursorPosition;
    
    public TextInsertionMemento(int position, String insertedText, 
                               int oldCursorPos, int newCursorPos) {
        super();
        this.position = position;
        this.insertedText = insertedText;
        this.oldCursorPosition = oldCursorPos;
        this.newCursorPosition = newCursorPos;
    }
    
    @Override
    public void undo(TextEditor editor) {
        // Remove the inserted text
        editor.deleteText(position, position + insertedText.length());
        editor.setCursorPosition(oldCursorPosition);
    }
    
    @Override
    public void redo(TextEditor editor) {
        // Re-insert the text
        editor.insertText(position, insertedText);
        editor.setCursorPosition(newCursorPosition);
    }
}

// Specific memento for text deletion
class TextDeletionMemento extends IncrementalMemento {
    private final int startPosition;
    private final String deletedText;
    private final int oldCursorPosition;
    private final int newCursorPosition;
    
    public TextDeletionMemento(int startPosition, String deletedText,
                              int oldCursorPos, int newCursorPos) {
        super();
        this.startPosition = startPosition;
        this.deletedText = deletedText;
        this.oldCursorPosition = oldCursorPos;
        this.newCursorPosition = newCursorPos;
    }
    
    @Override
    public void undo(TextEditor editor) {
        // Re-insert the deleted text
        editor.insertText(startPosition, deletedText);
        editor.setCursorPosition(oldCursorPosition);
    }
    
    @Override
    public void redo(TextEditor editor) {
        // Re-delete the text
        editor.deleteText(startPosition, startPosition + deletedText.length());
        editor.setCursorPosition(newCursorPosition);
    }
}

// Specific memento for cursor movement
class CursorMovementMemento extends IncrementalMemento {
    private final int oldPosition;
    private final int newPosition;
    
    public CursorMovementMemento(int oldPosition, int newPosition) {
        super();
        this.oldPosition = oldPosition;
        this.newPosition = newPosition;
    }
    
    @Override
    public void undo(TextEditor editor) {
        editor.setCursorPosition(oldPosition);
    }
    
    @Override
    public void redo(TextEditor editor) {
        editor.setCursorPosition(newPosition);
    }
}
```

```Java title='TextEditor Originator'
class TextEditor {
    private StringBuilder content;
    private int cursorPosition;
    private Map<String, String> metadata;
    
    public TextEditor() {
        this.content = new StringBuilder();
        this.cursorPosition = 0;
        this.metadata = new HashMap<>();
    }
    
    // ========================================================================
    // PUBLIC METHODS (WORK WITH CARETAKER)
    // ========================================================================
    
    public IncrementalMemento insertText(int position, String text) {
        int oldCursorPos = this.cursorPosition;
        
        // Perform the actual insertion
        content.insert(position, text);
        this.cursorPosition = position + text.length();
        
        // Return memento for this change (don't store it ourselves)
        return new TextInsertionMemento(position, text, oldCursorPos, this.cursorPosition);
    }
    
    public IncrementalMemento deleteText(int startPos, int endPos) {
        int oldCursorPos = this.cursorPosition;
        
        // Extract the text that will be deleted
        String deletedText = content.substring(startPos, endPos);
        
        // Perform the actual deletion
        content.delete(startPos, endPos);
        this.cursorPosition = startPos;
        
        // Return memento for this change
        return new TextDeletionMemento(startPos, deletedText, oldCursorPos, this.cursorPosition);
    }
    
    // ========================================================================
    // DIRECT METHODS (USED BY MEMENTOS FOR UNDO/REDO)
    // ========================================================================
    
    public void insertTextDirect(int position, String text) {
        content.insert(position, text);
    }
    
    public void deleteTextDirect(int startPos, int endPos) {
        content.delete(startPos, endPos);
    }
    
    public void setCursorPositionDirect(int position) {
        this.cursorPosition = position;
    }
    
    // ========================================================================
    // UTILITY METHODS
    // ========================================================================
    
    public String getContent() {
        return content.toString();
    }
    
    public int getCursorPosition() {
        return cursorPosition;
    }
    
    public void printState() {
        System.out.println("Content: \"" + content.toString() + "\"");
        System.out.println("Cursor: " + cursorPosition);
    }
}
```

```Java title='IncrementalHistory Caretaker'
// ============================================================================
// INCREMENTAL CARETAKER - MANAGES HISTORY
// ============================================================================

class IncrementalHistory {
    private Stack<IncrementalMemento> undoStack;
    private Stack<IncrementalMemento> redoStack;
    private int maxHistorySize;
    
    public IncrementalHistory() {
        this(1000); // Default max size
    }
    
    public IncrementalHistory(int maxHistorySize) {
        this.undoStack = new Stack<>();
        this.redoStack = new Stack<>();
        this.maxHistorySize = maxHistorySize;
    }
    
    public void recordChange(IncrementalMemento memento) {
        // Add to undo stack
        undoStack.push(memento);
        
        // Clear redo stack (new change invalidates redo history)
        redoStack.clear();
        
        // Maintain max history size
        while (undoStack.size() > maxHistorySize) {
            undoStack.remove(0); // Remove oldest
        }
    }
    
    public boolean undo(TextEditor editor) {
        if (!undoStack.isEmpty()) {
            IncrementalMemento memento = undoStack.pop();
            memento.undo(editor);
            redoStack.push(memento);
            return true;
        }
        return false;
    }
    
    public boolean redo(TextEditor editor) {
        if (!redoStack.isEmpty()) {
            IncrementalMemento memento = redoStack.pop();
            memento.redo(editor);
            undoStack.push(memento);
            return true;
        }
        return false;
    }
    
    public boolean canUndo() {
        return !undoStack.isEmpty();
    }
    
    public boolean canRedo() {
        return !redoStack.isEmpty();
    }
    
    public int getUndoCount() {
        return undoStack.size();
    }
    
    public int getRedoCount() {
        return redoStack.size();
    }
    
    public void printHistory() {
        System.out.println("=== HISTORY ===");
        System.out.println("Undo stack size: " + undoStack.size());
        System.out.println("Redo stack size: " + redoStack.size());
        
        if (!undoStack.isEmpty()) {
            System.out.println("Recent changes:");
            for (int i = Math.max(0, undoStack.size() - 5); i < undoStack.size(); i++) {
                System.out.println("  " + (i + 1) + ": " + undoStack.get(i));
            }
        }
        System.out.println("===============");
    }
    
    // Advanced features enabled by separate caretaker
    public void clearHistory() {
        undoStack.clear();
        redoStack.clear();
    }
    
    public List<IncrementalMemento> getUndoHistory() {
        return new ArrayList<>(undoStack);
    }
    
    public long getMemoryUsage() {
        // Estimate memory usage of stored mementos
        return (undoStack.size() + redoStack.size()) * 100; // Rough estimate
    }
}
```

```Java title='Client Main class'
class Main {
    public static void main(String[] args) {
        demonstrateBasicCaretaker();
        System.out.println("\n" + "=".repeat(60) + "\n");
        demonstrateAdvancedCaretaker();
    }
    
    private static void demonstrateBasicCaretaker() {
        System.out.println("BASIC INCREMENTAL CARETAKER:");
        
        TextEditor editor = new TextEditor();
        IncrementalHistory history = new IncrementalHistory();
        
        // Make changes and record them
        IncrementalMemento memento1 = editor.insertText(0, "Hello");
        history.recordChange(memento1);
        
        IncrementalMemento memento2 = editor.insertText(5, " World");
        history.recordChange(memento2);
        
        IncrementalMemento memento3 = editor.insertText(11, "!");
        history.recordChange(memento3);
        
        System.out.println("Final state: \"" + editor.getContent() + "\"");
        history.printHistory();
        
        // Undo operations
        history.undo(editor);
        System.out.println("After 1 undo: \"" + editor.getContent() + "\"");
        
        history.undo(editor);
        System.out.println("After 2 undo: \"" + editor.getContent() + "\"");
        
        // Redo operation
        history.redo(editor);
        System.out.println("After 1 redo: \"" + editor.getContent() + "\"");
        
        history.printHistory();
    }
}
```
### Traditional memento usage
#### Application
- State changes are complex and unpredictable.
- Any historical state can be randomly accessed.
- Memory consumption is not critical.
- Restoring state is simpler than replaying operations.
#### Usecases
- Game save states which are independent of each other.
- Configuration snapshots with small and frequent changes.
- Checkpoint systems when the restoration point must be guaranteed.
### Incremental memento
#### Application
- Operations follow a predictable sequence (like undo/redo).
- Memory efficiency is critical.
- Inverse operations are simple.
- There is a large number of small objects with frequent changes.
#### Usecases
- IDE redo/undo operations.
- Version control systems such as Git.
- Collaborative editing such as Google Docs.
- Database transaction logging systems.
## Embedded caretaker
- If the business logic of the Caretaker is not complicated, it may be directly embedded into the Originator class.
# Consequences
- Memento *preserving encapsulation boundaries*. Only the originator should manage the content of Memento but that information is stored nevertheless outside the originator. The pattern shields other objects from potentially complicate the Originator internals. $\implies$ ensure [[SOLID#Single responsibility principle]]
- The Originator is relieved of the storage management burden.
- Storing a large number of Memento objects is expensive. Additionally, heavy memento instances incur high memory consumption, not to mention the cost of copy operations.
# Real examples
- `java.io.Serializable`.
---
# References
1. Design Pattern Elements of Reusable Object-Oriented Software - Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides.
	1. Memento.
2. https://java-design-patterns.com/patterns/memento/
3. https://refactoring.guru/design-patterns/memento
4. [[SOLID]]
5. 