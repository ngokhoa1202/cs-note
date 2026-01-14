#application-layer #email #computer-network #protocol #mime #smtp #encoding
## Overview

==Multipurpose Internet Mail Extensions (MIME)== is an Internet standard that extends the format of email messages to support text in character sets other than ASCII, non-text attachments (audio, video, images, application programs), message bodies with multiple parts, and header information in non-ASCII character sets.

MIME was designed to overcome the limitations of ==Simple Mail Transfer Protocol (SMTP)==, which was originally designed to transmit only 7-bit ASCII text. MIME enables emails to contain:
- **Rich text formatting**: HTML, RTF, and other formatted text
- **Binary attachments**: Images, audio, video, executable files
- **Multiple character sets**: UTF-8, ISO-8859-1, Unicode
- **Multipart messages**: Combining text and attachments in a single message
- **Non-English text**: Supporting international languages

**Historical Context:**

Before MIME (pre-1992), email could only contain 7-bit ASCII text with line lengths limited to 1000 characters. Any binary data had to be manually encoded using tools like `uuencode`. MIME standardized these mechanisms and made email a universal communication platform.

## MIME Architecture

MIME extends the RFC 822 email format by adding structured headers that describe the message content. A MIME-compliant message consists of:

**1. MIME Headers**: Metadata describing content type, encoding, and structure
**2. Message Body**: Actual content encoded according to headers
**3. Boundary Markers**: Delimiters for multipart messages

### MIME Version Header

```Text
MIME-Version: 1.0
```

This header ==must appear== in all MIME-compliant messages. It indicates that the message follows MIME specifications. Current version is **1.0** (defined in 1996 and still current).

## MIME Headers

### Content-Type Header

The ==Content-Type== header specifies the ==media type== of the message body. It follows the format:

```Text
Content-Type: type/subtype; parameters
```

**Structure:**
- **type**: Top-level media type (text, image, audio, video, application, multipart, message)
- **subtype**: Specific format within the type
- **parameters**: Optional attributes (charset, boundary, name)

**Common Content Types:**

| Content-Type | Description | File Extensions |
|--------------|-------------|-----------------|
| `text/plain` | Plain ASCII text | .txt |
| `text/html` | HTML formatted text | .html, .htm |
| `text/css` | Cascading Style Sheets | .css |
| `text/javascript` | JavaScript code | .js |
| `image/jpeg` | JPEG images | .jpg, .jpeg |
| `image/png` | PNG images | .png |
| `image/gif` | GIF images | .gif |
| `image/svg+xml` | SVG vector graphics | .svg |
| `audio/mpeg` | MP3 audio | .mp3 |
| `audio/wav` | WAV audio | .wav |
| `video/mp4` | MP4 video | .mp4 |
| `video/mpeg` | MPEG video | .mpeg, .mpg |
| `application/pdf` | PDF documents | .pdf |
| `application/json` | JSON data | .json |
| `application/xml` | XML data | .xml |
| `application/zip` | ZIP archives | .zip |
| `application/octet-stream` | Binary data (generic) | any |

**Examples:**

```Text title='Content-Type examples'
Content-Type: text/plain; charset=UTF-8

Content-Type: text/html; charset=ISO-8859-1

Content-Type: image/jpeg

Content-Type: application/pdf; name="document.pdf"

Content-Type: multipart/mixed; boundary="----=_Part_123456"

Content-Type: application/json; charset=UTF-8
```

### Content-Transfer-Encoding Header

The ==Content-Transfer-Encoding== header specifies how the message body is ==encoded for transmission== over 7-bit SMTP transport. This encoding ensures binary data can be transmitted safely through email systems that only support ASCII text.

**Encoding Types:**

**1. 7bit (default)**
- No encoding applied
- Only 7-bit ASCII characters (0-127)
- Lines must not exceed 998 characters
- Used for plain ASCII text

```Text
Content-Transfer-Encoding: 7bit
```

**2. 8bit**
- Allows 8-bit characters (0-255)
- Requires 8-bit clean transport (modern SMTP with 8BITMIME extension)
- Lines must not exceed 998 characters
- Used for extended ASCII and some Unicode

```Text
Content-Transfer-Encoding: 8bit
```

**3. binary**
- No restrictions on character values or line length
- Rarely supported by email systems
- Requires binary-capable transport

```Text
Content-Transfer-Encoding: binary
```

**4. quoted-printable**
- Encodes non-ASCII and special characters using ==printable ASCII==
- Format: `=XX` where XX is hexadecimal byte value
- Efficient for text with occasional non-ASCII characters
- Human-readable for mostly ASCII content

```Text title='Quoted-printable encoding example'
Content-Transfer-Encoding: quoted-printable

Hello=20World=21
Caf=C3=A9
R=C3=A9sum=C3=A9
```

Decoded output:
```
Hello World!
Café
Résumé
```

**Encoding Rules:**
- Non-printable characters encoded as `=XX`
- `=` character encoded as `=3D`
- Spaces at line end encoded as `=20`
- Soft line breaks: `=` at end of line

**5. base64**
- Encodes binary data using ==64 printable ASCII characters==
- Increases size by approximately 33%
- Used for images, audio, video, and binary files
- Most common encoding for attachments

```Text title='Base64 encoding example'
Content-Transfer-Encoding: base64

SGVsbG8gV29ybGQh
```

Decoded output: `Hello World!`

**Encoding Comparison:**

| Encoding | Efficiency | Use Case | Overhead |
|----------|-----------|----------|----------|
| **7bit** | 100% | ASCII text only | 0% |
| **8bit** | 100% | Extended ASCII text | 0% |
| **quoted-printable** | 95-99% | Text with few non-ASCII chars | 1-5% |
| **base64** | 75% | Binary data, images, attachments | 33% |

### Content-Disposition Header

Specifies how the content should be ==displayed or handled== by the email client.

```Text title='Content-Disposition values'
Content-Disposition: inline

Content-Disposition: attachment; filename="document.pdf"

Content-Disposition: attachment; filename="photo.jpg"; size=123456
```

**Parameters:**
- **inline**: Display content within email body
- **attachment**: Treat as downloadable file
- **filename**: Suggested filename for saving
- **size**: Content size in bytes (optional)

### Content-ID Header

Provides a ==unique identifier== for MIME parts, allowing references within multipart messages (e.g., embedding images in HTML).

```Text
Content-ID: <image001@example.com>
```

Referenced in HTML:
```HTML
<img src="cid:image001@example.com">
```

### Content-Description Header

Optional ==human-readable description== of the content.

```Text
Content-Description: Company Logo
Content-Description: Quarterly Financial Report
```

## MIME Content Types

### Text Types

**text/plain**

Plain unformatted text. Most basic MIME type.

```Text title='text/plain message'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This is a plain text message.
It supports Unicode: Caf=C3=A9, 日本語, العربية
```

**text/html**

HTML formatted email with rich styling, links, and embedded content.

```Text title='text/html message'
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
<head>
    <style>
        body { font-family: Arial, sans-serif; }
        .highlight { color: blue; font-weight: bold; }
    </style>
</head>
<body>
    <h1>Welcome!</h1>
    <p>This is <span class="highlight">HTML email</span>.</p>
    <a href="https://example.com">Click here</a>
</body>
</html>
```

### Image Types

```Text title='Image attachment'
Content-Type: image/jpeg; name="photo.jpg"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="photo.jpg"

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0a
HBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIy
...
```

### Application Types

**application/pdf**

PDF document attachment.

```Text title='PDF attachment'
Content-Type: application/pdf; name="report.pdf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="report.pdf"

JVBERi0xLjQKJeLjz9MKMSAwIG9iago8PC9UeXBlL0NhdGFsb2cvUGFnZXMgMiAwIFI+PgplbmRv
YmoKMiAwIG9iago8PC9UeXBlL1BhZ2VzL0NvdW50IDEvS2lkc1szIDAgUl0+PgplbmRvYmoKMyAw
...
```

**application/json**

JSON data payload.

```Text title='JSON data'
Content-Type: application/json; charset=UTF-8
Content-Transfer-Encoding: 7bit

{
    "name": "John Doe",
    "email": "john@example.com",
    "age": 30
}
```

### Multipart Types

==Multipart messages== contain multiple MIME parts separated by ==boundary markers==. Essential for emails with both text and attachments.

![](Pasted%20image%2020240514160525.png)

**multipart/mixed**

Container for ==mixed content types== (text + attachments).

```Text title='multipart/mixed example'
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_Part_123456"

------=_Part_123456
Content-Type: text/plain; charset=UTF-8

This is the text part of the email.

------=_Part_123456
Content-Type: application/pdf; name="document.pdf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="document.pdf"

JVBERi0xLjQKJeLjz9MK...

------=_Part_123456--
```

**multipart/alternative**

Contains ==alternative representations== of the same content (plain text + HTML).

```Text title='multipart/alternative example'
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="----=_Alt_123456"

------=_Alt_123456
Content-Type: text/plain; charset=UTF-8

This is the plain text version.
View this email in a modern client for better formatting.

------=_Alt_123456
Content-Type: text/html; charset=UTF-8

<!DOCTYPE html>
<html>
<body>
    <h1>This is the HTML version</h1>
    <p style="color: blue;">Rich formatting available!</p>
</body>
</html>

------=_Alt_123456--
```

Email clients display the ==last alternative== they support (usually HTML).

**multipart/related**

Groups ==related MIME parts== (HTML + embedded images).

![](Pasted%20image%2020240514160744.png)

```Text title='multipart/related with embedded image'
MIME-Version: 1.0
Content-Type: multipart/related; boundary="----=_Related_123456"

------=_Related_123456
Content-Type: text/html; charset=UTF-8

<!DOCTYPE html>
<html>
<body>
    <h1>Email with Embedded Image</h1>
    <img src="cid:logo@example.com" alt="Company Logo">
</body>
</html>

------=_Related_123456
Content-Type: image/png; name="logo.png"
Content-Transfer-Encoding: base64
Content-ID: <logo@example.com>
Content-Disposition: inline; filename="logo.png"

iVBORw0KGgoAAAANSUhEUgAAAAUA...

------=_Related_123456--
```

**multipart/digest**

Container for ==multiple email messages== (used in email digests).

```Text title='multipart/digest'
Content-Type: multipart/digest; boundary="----=_Digest_123456"

------=_Digest_123456
Content-Type: message/rfc822

From: sender1@example.com
Subject: First Message
...

------=_Digest_123456
Content-Type: message/rfc822

From: sender2@example.com
Subject: Second Message
...

------=_Digest_123456--
```

**Complex Nested Multipart Example:**

```Text title='Real-world email structure'
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_Outer_Boundary"

------=_Outer_Boundary
Content-Type: multipart/alternative; boundary="----=_Inner_Boundary"

------=_Inner_Boundary
Content-Type: text/plain; charset=UTF-8

Plain text version of the email.

------=_Inner_Boundary
Content-Type: multipart/related; boundary="----=_Related_Boundary"

------=_Related_Boundary
Content-Type: text/html; charset=UTF-8

<html>
<body>
    <h1>HTML Email</h1>
    <img src="cid:logo@example.com">
</body>
</html>

------=_Related_Boundary
Content-Type: image/png
Content-ID: <logo@example.com>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAAUA...

------=_Related_Boundary--

------=_Inner_Boundary--

------=_Outer_Boundary
Content-Type: application/pdf; name="attachment.pdf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.pdf"

JVBERi0xLjQKJeLjz9MK...

------=_Outer_Boundary--
```

**Structure:**
```
multipart/mixed (outer)
├── multipart/alternative
│   ├── text/plain (fallback)
│   └── multipart/related
│       ├── text/html (main content)
│       └── image/png (embedded logo)
└── application/pdf (attachment)
```

## Practical MIME Examples

### Python Email Generation

```Python title='Send MIME email with Python smtplib'
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email.mime.image import MIMEImage
from email import encoders

def send_mime_email():
    """Send multipart MIME email with attachments"""

    # Create message container
    msg = MIMEMultipart('mixed')
    msg['From'] = 'sender@example.com'
    msg['To'] = 'recipient@example.com'
    msg['Subject'] = 'MIME Email with Attachments'

    # Create alternative part (text + HTML)
    msg_alternative = MIMEMultipart('alternative')
    msg.attach(msg_alternative)

    # Plain text version
    text_part = MIMEText('This is the plain text version.', 'plain', 'utf-8')
    msg_alternative.attach(text_part)

    # HTML version
    html_content = """
    <html>
        <body>
            <h1>HTML Email</h1>
            <p>This is the <strong>HTML version</strong>.</p>
            <img src="cid:logo123">
        </body>
    </html>
    """
    html_part = MIMEText(html_content, 'html', 'utf-8')
    msg_alternative.attach(html_part)

    # Embed image with Content-ID
    with open('logo.png', 'rb') as img_file:
        img = MIMEImage(img_file.read())
        img.add_header('Content-ID', '<logo123>')
        img.add_header('Content-Disposition', 'inline', filename='logo.png')
        msg.attach(img)

    # Add PDF attachment
    with open('document.pdf', 'rb') as pdf_file:
        pdf = MIMEBase('application', 'pdf')
        pdf.set_payload(pdf_file.read())
        encoders.encode_base64(pdf)
        pdf.add_header('Content-Disposition', 'attachment', filename='document.pdf')
        msg.attach(pdf)

    # Send email
    with smtplib.SMTP('smtp.example.com', 587) as server:
        server.starttls()
        server.login('username', 'password')
        server.send_message(msg)

    print('Email sent successfully!')

send_mime_email()
```

**Parse MIME Email:**

```Python title='Parse MIME email with Python'
import email
from email import policy
from email.parser import BytesParser

def parse_mime_email(email_bytes):
    """Parse and extract MIME email components"""

    # Parse email
    msg = BytesParser(policy=policy.default).parsebytes(email_bytes)

    print(f"From: {msg['From']}")
    print(f"To: {msg['To']}")
    print(f"Subject: {msg['Subject']}")
    print(f"MIME-Version: {msg['MIME-Version']}")
    print(f"Content-Type: {msg.get_content_type()}")
    print()

    # Walk through MIME parts
    for part in msg.walk():
        content_type = part.get_content_type()
        content_disposition = part.get_content_disposition()

        print(f"Part: {content_type}")
        print(f"  Disposition: {content_disposition}")
        print(f"  Encoding: {part.get('Content-Transfer-Encoding', 'N/A')}")

        # Extract text content
        if content_type == 'text/plain':
            text = part.get_content()
            print(f"  Text: {text[:100]}...")

        # Extract HTML content
        elif content_type == 'text/html':
            html = part.get_content()
            print(f"  HTML length: {len(html)} characters")

        # Save attachments
        elif content_disposition == 'attachment':
            filename = part.get_filename()
            if filename:
                with open(f"extracted_{filename}", 'wb') as f:
                    f.write(part.get_payload(decode=True))
                print(f"  Saved attachment: {filename}")

        print()

# Read email from file
with open('email.eml', 'rb') as f:
    email_data = f.read()

parse_mime_email(email_data)
```

### Node.js Email Generation

```JavaScript title='Send MIME email with Nodemailer'
const nodemailer = require('nodemailer');
const fs = require('fs');

async function sendMimeEmail() {
    // Create transporter
    const transporter = nodemailer.createTransport({
        host: 'smtp.example.com',
        port: 587,
        secure: false,
        auth: {
            user: 'username',
            pass: 'password'
        }
    });

    // Email options
    const mailOptions = {
        from: 'sender@example.com',
        to: 'recipient@example.com',
        subject: 'MIME Email with Attachments',

        // Plain text version
        text: 'This is the plain text version.',

        // HTML version with embedded image
        html: `
            <html>
                <body>
                    <h1>HTML Email</h1>
                    <p>This is the <strong>HTML version</strong>.</p>
                    <img src="cid:logo123">
                </body>
            </html>
        `,

        // Attachments
        attachments: [
            {
                // Embedded image
                filename: 'logo.png',
                path: './logo.png',
                cid: 'logo123' // Content-ID for embedding
            },
            {
                // PDF attachment
                filename: 'document.pdf',
                path: './document.pdf',
                contentType: 'application/pdf'
            },
            {
                // Inline text file
                filename: 'readme.txt',
                content: 'This is inline text content',
                contentType: 'text/plain'
            },
            {
                // Base64 encoded attachment
                filename: 'data.json',
                content: Buffer.from(JSON.stringify({ key: 'value' })).toString('base64'),
                encoding: 'base64',
                contentType: 'application/json'
            }
        ]
    };

    // Send email
    try {
        const info = await transporter.sendMail(mailOptions);
        console.log('Email sent:', info.messageId);
        console.log('Preview URL:', nodemailer.getTestMessageUrl(info));
    } catch (error) {
        console.error('Error sending email:', error);
    }
}

sendMimeEmail();
```

**Parse MIME Email:**

```JavaScript title='Parse MIME email with mailparser'
const { simpleParser } = require('mailparser');
const fs = require('fs');

async function parseMimeEmail(emailPath) {
    const emailSource = fs.readFileSync(emailPath);

    try {
        const parsed = await simpleParser(emailSource);

        console.log('From:', parsed.from.text);
        console.log('To:', parsed.to.text);
        console.log('Subject:', parsed.subject);
        console.log('Date:', parsed.date);
        console.log();

        // Text content
        if (parsed.text) {
            console.log('Text content:');
            console.log(parsed.text.substring(0, 200));
            console.log();
        }

        // HTML content
        if (parsed.html) {
            console.log('HTML content length:', parsed.html.length);
            console.log();
        }

        // Attachments
        if (parsed.attachments && parsed.attachments.length > 0) {
            console.log('Attachments:');
            parsed.attachments.forEach(attachment => {
                console.log(`  - ${attachment.filename}`);
                console.log(`    Type: ${attachment.contentType}`);
                console.log(`    Size: ${attachment.size} bytes`);
                console.log(`    Content-ID: ${attachment.cid || 'N/A'}`);

                // Save attachment
                fs.writeFileSync(
                    `extracted_${attachment.filename}`,
                    attachment.content
                );
            });
        }

    } catch (error) {
        console.error('Error parsing email:', error);
    }
}

parseMimeEmail('email.eml');
```

### Java Email Generation

```Java title='Send MIME email with JavaMail'
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import java.util.Properties;

public class MimeEmailSender {

    public static void sendMimeEmail() throws Exception {
        // SMTP configuration
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.example.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Authentication
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("username", "password");
            }
        });

        // Create message
        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress("sender@example.com"));
        message.setRecipients(Message.RecipientType.TO,
            InternetAddress.parse("recipient@example.com"));
        message.setSubject("MIME Email with Attachments");

        // Create multipart content
        MimeMultipart multipart = new MimeMultipart("mixed");

        // Create alternative part (text + HTML)
        MimeMultipart alternative = new MimeMultipart("alternative");

        // Plain text part
        MimeBodyPart textPart = new MimeBodyPart();
        textPart.setText("This is the plain text version.", "UTF-8");
        alternative.addBodyPart(textPart);

        // HTML part with embedded image
        MimeMultipart related = new MimeMultipart("related");

        MimeBodyPart htmlPart = new MimeBodyPart();
        String htmlContent = """
            <html>
                <body>
                    <h1>HTML Email</h1>
                    <p>This is the <strong>HTML version</strong>.</p>
                    <img src="cid:logo123">
                </body>
            </html>
        """;
        htmlPart.setContent(htmlContent, "text/html; charset=UTF-8");
        related.addBodyPart(htmlPart);

        // Embed image
        MimeBodyPart imagePart = new MimeBodyPart();
        DataSource imageSource = new FileDataSource("logo.png");
        imagePart.setDataHandler(new DataHandler(imageSource));
        imagePart.setContentID("<logo123>");
        imagePart.setDisposition(MimeBodyPart.INLINE);
        imagePart.setFileName("logo.png");
        related.addBodyPart(imagePart);

        // Wrap related in body part
        MimeBodyPart relatedWrapper = new MimeBodyPart();
        relatedWrapper.setContent(related);
        alternative.addBodyPart(relatedWrapper);

        // Wrap alternative in body part
        MimeBodyPart alternativeWrapper = new MimeBodyPart();
        alternativeWrapper.setContent(alternative);
        multipart.addBodyPart(alternativeWrapper);

        // Add PDF attachment
        MimeBodyPart pdfPart = new MimeBodyPart();
        DataSource pdfSource = new FileDataSource("document.pdf");
        pdfPart.setDataHandler(new DataHandler(pdfSource));
        pdfPart.setFileName("document.pdf");
        pdfPart.setDisposition(MimeBodyPart.ATTACHMENT);
        multipart.addBodyPart(pdfPart);

        // Set content
        message.setContent(multipart);

        // Send email
        Transport.send(message);
        System.out.println("Email sent successfully!");
    }

    public static void main(String[] args) {
        try {
            sendMimeEmail();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

## MIME Encoding in Practice

### Base64 Encoding/Decoding

```Python title='Base64 encoding in Python'
import base64

# Encode binary data
data = b"Hello World!"
encoded = base64.b64encode(data)
print(f"Encoded: {encoded.decode('ascii')}")
# Output: SGVsbG8gV29ybGQh

# Decode base64
decoded = base64.b64decode(encoded)
print(f"Decoded: {decoded.decode('utf-8')}")
# Output: Hello World!

# Encode file
with open('image.jpg', 'rb') as f:
    image_data = f.read()
    encoded_image = base64.b64encode(image_data)
    print(f"Image size: {len(image_data)} bytes")
    print(f"Encoded size: {len(encoded_image)} bytes")
    print(f"Overhead: {(len(encoded_image) - len(image_data)) / len(image_data) * 100:.1f}%")

# Decode and save file
with open('decoded_image.jpg', 'wb') as f:
    f.write(base64.b64decode(encoded_image))
```

```JavaScript title='Base64 encoding in Node.js'
// Encode string
const text = "Hello World!";
const encoded = Buffer.from(text).toString('base64');
console.log('Encoded:', encoded);
// Output: SGVsbG8gV29ybGQh

// Decode string
const decoded = Buffer.from(encoded, 'base64').toString('utf-8');
console.log('Decoded:', decoded);
// Output: Hello World!

// Encode file
const fs = require('fs');
const fileData = fs.readFileSync('image.jpg');
const encodedFile = fileData.toString('base64');
console.log('Original size:', fileData.length, 'bytes');
console.log('Encoded size:', encodedFile.length, 'bytes');

// Decode and save file
const decodedFile = Buffer.from(encodedFile, 'base64');
fs.writeFileSync('decoded_image.jpg', decodedFile);
```

```Java title='Base64 encoding in Java'
import java.util.Base64;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.io.IOException;

public class Base64Example {

    public static void main(String[] args) throws IOException {
        // Encode string
        String text = "Hello World!";
        String encoded = Base64.getEncoder().encodeToString(text.getBytes());
        System.out.println("Encoded: " + encoded);
        // Output: SGVsbG8gV29ybGQh

        // Decode string
        byte[] decoded = Base64.getDecoder().decode(encoded);
        System.out.println("Decoded: " + new String(decoded));
        // Output: Hello World!

        // Encode file
        byte[] fileData = Files.readAllBytes(Paths.get("image.jpg"));
        String encodedFile = Base64.getEncoder().encodeToString(fileData);
        System.out.println("Original size: " + fileData.length + " bytes");
        System.out.println("Encoded size: " + encodedFile.length() + " bytes");

        // Decode and save file
        byte[] decodedFile = Base64.getDecoder().decode(encodedFile);
        Files.write(Paths.get("decoded_image.jpg"), decodedFile);

        // MIME encoding (line breaks every 76 characters)
        String mimeEncoded = Base64.getMimeEncoder().encodeToString(fileData);
        System.out.println("MIME encoded with line breaks:");
        System.out.println(mimeEncoded.substring(0, 200));
    }
}
```

### Quoted-Printable Encoding/Decoding

```Python title='Quoted-printable encoding in Python'
import quopri

# Encode text
text = "Café, Résumé, 日本語"
encoded = quopri.encodestring(text.encode('utf-8'))
print(f"Encoded: {encoded.decode('ascii')}")
# Output: Caf=C3=A9, R=C3=A9sum=C3=A9, =E6=97=A5=E6=9C=AC=E8=AA=9E

# Decode text
decoded = quopri.decodestring(encoded)
print(f"Decoded: {decoded.decode('utf-8')}")
# Output: Café, Résumé, 日本語

# Encode with header mode (spaces as underscores)
import email.quoprimime
header_encoded = email.quoprimime.header_encode(text.encode('utf-8'), 'utf-8')
print(f"Header encoded: {header_encoded}")
```

## MIME Security Considerations

### Content Type Spoofing

Malicious attachments can disguise their true type:

```Text title='Dangerous content type spoofing'
Content-Type: text/plain; name="harmless.txt"
Content-Disposition: attachment; filename="malware.exe"
```

**Mitigation:**
- Validate file extensions against Content-Type
- Scan attachments with antivirus
- Block executable MIME types
- Verify magic numbers in file headers

### Email Size Limits

SMTP servers impose size limits on messages:

```Python title='Check MIME message size'
def check_message_size(msg):
    """Check if MIME message exceeds size limits"""
    message_bytes = msg.as_bytes()
    size_mb = len(message_bytes) / (1024 * 1024)

    print(f"Message size: {size_mb:.2f} MB")

    # Typical limits
    if size_mb > 25:
        print("Warning: Exceeds Gmail limit (25 MB)")
    if size_mb > 50:
        print("Warning: Exceeds typical SMTP server limit")

    return size_mb
```

### HTML Injection and XSS

HTML emails can contain malicious scripts:

```Python title='Sanitize HTML content'
import bleach

def sanitize_html(html_content):
    """Remove dangerous HTML tags and attributes"""
    allowed_tags = ['p', 'br', 'strong', 'em', 'u', 'a', 'h1', 'h2', 'h3', 'ul', 'ol', 'li']
    allowed_attrs = {'a': ['href', 'title']}

    clean_html = bleach.clean(
        html_content,
        tags=allowed_tags,
        attributes=allowed_attrs,
        strip=True
    )

    return clean_html

# Example usage
dangerous_html = """
<html>
<body>
    <script>alert('XSS')</script>
    <p>Safe content</p>
    <iframe src="malicious.com"></iframe>
</body>
</html>
"""

safe_html = sanitize_html(dangerous_html)
print(safe_html)
# Output: <p>Safe content</p>
```

## MIME Tools and Utilities

### Command-Line MIME Tools

```Shell title='Extract MIME parts with munpack'
# Install mpack package
$ sudo apt-get install mpack

# Extract all attachments from email
$ munpack email.eml

# Output files:
# - part1.txt (text part)
# - document.pdf (attachment)
# - image.jpg (attachment)
```

```Shell title='View MIME structure with mhshow'
# Display MIME structure
$ mhshow -verbose email.eml

# Show specific MIME part
$ mhshow -part 2 email.eml

# Save MIME part to file
$ mhshow -part 3 -store email.eml
```

```Shell title='Create MIME email with mpack'
# Create MIME email with attachment
$ mpack -s "Subject line" -o output.eml document.pdf recipient@example.com

# Multiple attachments
$ mpack -s "Multiple files" -o output.eml file1.pdf file2.jpg recipient@example.com
```

### Online MIME Tools

**MXToolbox Email Header Analyzer**: https://mxtoolbox.com/EmailHeaders.aspx
- Parse email headers and MIME structure
- Visualize email routing path
- Detect authentication issues

**MIME Parser Online**: Various online tools for parsing MIME messages
- Extract attachments
- View MIME tree structure
- Decode base64/quoted-printable

## Real-World Use Cases

### Automated Email Reports

```Python title='Send daily report email'
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
from datetime import datetime
import pandas as pd
import matplotlib.pyplot as plt

def send_daily_report():
    """Generate and send daily sales report"""

    # Generate report data
    date_str = datetime.now().strftime('%Y-%m-%d')

    # Create CSV report
    data = {
        'Product': ['Widget A', 'Widget B', 'Widget C'],
        'Sales': [150, 230, 180],
        'Revenue': [1500, 3450, 2160]
    }
    df = pd.DataFrame(data)
    csv_filename = f'sales_report_{date_str}.csv'
    df.to_csv(csv_filename, index=False)

    # Create chart
    plt.figure(figsize=(10, 6))
    plt.bar(data['Product'], data['Sales'])
    plt.title(f'Sales Report - {date_str}')
    plt.xlabel('Product')
    plt.ylabel('Units Sold')
    chart_filename = f'sales_chart_{date_str}.png'
    plt.savefig(chart_filename)
    plt.close()

    # Compose email
    msg = MIMEMultipart('mixed')
    msg['From'] = 'reports@example.com'
    msg['To'] = 'manager@example.com'
    msg['Subject'] = f'Daily Sales Report - {date_str}'

    # HTML body with embedded chart
    html_body = f"""
    <html>
        <body>
            <h2>Daily Sales Report</h2>
            <p>Date: {date_str}</p>
            <p>Total Revenue: ${sum(data['Revenue']):,}</p>
            <img src="cid:chart123" width="600">
            <p>Detailed report attached.</p>
        </body>
    </html>
    """

    html_part = MIMEText(html_body, 'html')
    msg.attach(html_part)

    # Embed chart
    with open(chart_filename, 'rb') as f:
        img = MIMEBase('image', 'png')
        img.set_payload(f.read())
        encoders.encode_base64(img)
        img.add_header('Content-ID', '<chart123>')
        img.add_header('Content-Disposition', 'inline', filename=chart_filename)
        msg.attach(img)

    # Attach CSV
    with open(csv_filename, 'rb') as f:
        csv_part = MIMEBase('text', 'csv')
        csv_part.set_payload(f.read())
        encoders.encode_base64(csv_part)
        csv_part.add_header('Content-Disposition', 'attachment', filename=csv_filename)
        msg.attach(csv_part)

    # Send email
    with smtplib.SMTP('smtp.example.com', 587) as server:
        server.starttls()
        server.login('username', 'password')
        server.send_message(msg)

    print(f'Report sent: {date_str}')

send_daily_report()
```

### Newsletter with Template

```JavaScript title='Send HTML newsletter'
const nodemailer = require('nodemailer');
const fs = require('fs');
const handlebars = require('handlebars');

async function sendNewsletter(recipients, data) {
    // Load HTML template
    const templateSource = fs.readFileSync('newsletter_template.html', 'utf-8');
    const template = handlebars.compile(templateSource);

    // Render template with data
    const html = template({
        title: data.title,
        articles: data.articles,
        unsubscribeLink: 'https://example.com/unsubscribe'
    });

    const transporter = nodemailer.createTransport({
        host: 'smtp.example.com',
        port: 587,
        auth: { user: 'username', pass: 'password' }
    });

    // Send to each recipient
    for (const recipient of recipients) {
        const mailOptions = {
            from: 'newsletter@example.com',
            to: recipient,
            subject: data.title,
            html: html,
            text: 'Please view this email in an HTML-capable client.'
        };

        await transporter.sendMail(mailOptions);
        console.log(`Sent to: ${recipient}`);
    }
}

// Usage
const newsletterData = {
    title: 'Weekly Tech News',
    articles: [
        { title: 'Article 1', summary: 'Summary...', link: 'https://...' },
        { title: 'Article 2', summary: 'Summary...', link: 'https://...' }
    ]
};

sendNewsletter(['user1@example.com', 'user2@example.com'], newsletterData);
```

***
# References
1. RFC 2045 - Multipurpose Internet Mail Extensions (MIME) Part One: Format of Internet Message Bodies
	1. https://www.rfc-editor.org/rfc/rfc2045 for MIME format specification
2. RFC 2046 - MIME Part Two: Media Types
	1. https://www.rfc-editor.org/rfc/rfc2046 for content types specification
3. RFC 2047 - MIME Part Three: Message Header Extensions for Non-ASCII Text
	1. https://www.rfc-editor.org/rfc/rfc2047 for encoded-word syntax
4. RFC 2048 - MIME Part Four: Registration Procedures
	1. https://www.rfc-editor.org/rfc/rfc2048 for media type registration
5. RFC 2049 - MIME Part Five: Conformance Criteria and Examples
	1. https://www.rfc-editor.org/rfc/rfc2049 for MIME conformance
6. RFC 2183 - Communicating Presentation Information in Internet Messages: The Content-Disposition Header Field
	1. https://www.rfc-editor.org/rfc/rfc2183 for Content-Disposition specification
7. RFC 2231 - MIME Parameter Value and Encoded Word Extensions
	1. https://www.rfc-editor.org/rfc/rfc2231 for parameter encoding
8. Computer Networking: A Top-Down Approach, Global Edition, 8th Edition - James F. Kurose, Keith W. Ross - Pearson (2021)
	1. Chapter 2: Application Layer
		1. Section 2.3: Electronic Mail in the Internet
9. https://www.iana.org/assignments/media-types/media-types.xhtml for official MIME type registry
10. https://nodemailer.com/about/ for Nodemailer documentation
11. https://docs.python.org/3/library/email.html for Python email library
12. https://javaee.github.io/javamail/ for JavaMail API documentation
13. https://www.base64encode.org/ for online Base64 encoding/decoding
14. https://mailparser.io/ for email parsing library documentation