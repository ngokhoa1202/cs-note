#ajax #vanilla-javascript #event-driven-programming #concurrency-control #javascript #software-engineering #software-architecture #legacy 

# Definition
- AJAX (short for Asynchronous JavaScript and XML) is a method of asynchronously exchanging data with a server in the background and updating parts of a web page — without the need for an entire page refresh (postback).
# Architecture
- Every user action that normally would generate an HTTP request takes the form of a JavaScript call to the **Ajax engine** instead. 
- Any response to a user action that **doesn’t require a trip back to the server** — such as simple data validation, editing data in memory, and even some navigation — the engine handles on its own. 
- If the engine needs something from the server in order to respond — if it’s submitting data for processing, loading additional interface code, or retrieving new data — the engine makes those requests **asynchronously**, usually using XML, without stalling a user’s interaction with the application.
- ![[Pasted image 20250628185037.png]]
- ![[Pasted image 20250628191001.png]]
# Usage

```Javascript title='AJAX example'
function loadDoc() {
  const xhttp = new XMLHttpRequest();
  xhttp.onload = function() {
    document.getElementById("demo").innerHTML = this.responseText;
    }
  xhttp.open("GET", "ajax_info.txt", true);
  xhttp.send();
}
```

# Application
- AJAX is the underlying concept/technology that both `fetch` and `axios` implement.
---
# References
1. https://websocket.org/guides/road-to-websockets/
2. Ajax: A New Approach to Web Applications - Jesse James Garrett - February 18, 2005. Link: https://designftw.mit.edu/lectures/apis/ajax_adaptive_path.pdf
3. 