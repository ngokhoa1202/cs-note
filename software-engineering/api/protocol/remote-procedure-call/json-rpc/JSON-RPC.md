#json-rpc #remote-procedure-call #json #lightweight #web-api #blockchain
==JSON-RPC== is a lightweight remote procedure call protocol encoded in JSON. It defines a simple message format for requesting method execution and returning results, making it ideal for web applications, browser-based clients, and blockchain interactions.

## Specification

JSON-RPC 2.0 is the current specification, defining stateless, transport-agnostic protocol for RPC communication.

### Key Characteristics
- **Lightweight**: Minimal specification, easy to implement
- **Language-independent**: JSON serialization supported by all major languages
- **Transport-agnostic**: Works over HTTP, WebSocket, TCP, or any message-passing transport
- **Stateless**: Each request is independent

## Message Format

### Request

```json
{
    "jsonrpc": "2.0",
    "method": "createOrder",
    "params": {
        "userId": "user-123",
        "items": [
            {"productId": "prod-1", "quantity": 2}
        ],
        "totalAmount": 99.99
    },
    "id": 1
}
```

**Fields:**
- **jsonrpc**: Protocol version, always `"2.0"`
- **method**: String containing method name to invoke
- **params**: Structured value (object or array) holding parameter values
- **id**: Request identifier for matching responses (string, number, or null)

### Response (Success)

```json
{
    "jsonrpc": "2.0",
    "result": {
        "orderId": "ord-456",
        "status": "CREATED",
        "createdAt": 1704967200000
    },
    "id": 1
}
```

**Fields:**
- **jsonrpc**: Protocol version
- **result**: Method execution result (any JSON type)
- **id**: Matches request id

### Response (Error)

```json
{
    "jsonrpc": "2.0",
    "error": {
        "code": -32602,
        "message": "Invalid params",
        "data": {
            "field": "totalAmount",
            "issue": "must be positive"
        }
    },
    "id": 1
}
```

**Error Object:**
- **code**: Integer error code
- **message**: String describing error
- **data**: Optional additional information

### Notification (No Response Expected)

```json
{
    "jsonrpc": "2.0",
    "method": "logEvent",
    "params": {"event": "user_login", "userId": "user-123"}
}
```

Request without `id` field indicates notification. Server must not respond.

## Standard Error Codes

```mermaid
graph TD
    E1[-32700<br/>Parse Error] --> style1[Invalid JSON]
    E2[-32600<br/>Invalid Request] --> style2[Malformed request]
    E3[-32601<br/>Method Not Found] --> style3[Unknown method]
    E4[-32602<br/>Invalid Params] --> style4[Wrong parameters]
    E5[-32603<br/>Internal Error] --> style5[Server error]
    E6[-32000 to -32099<br/>Server Error] --> style6[Implementation-defined]

    style E1 fill:#fcc,stroke:#333
    style E3 fill:#fcc,stroke:#333
    style E5 fill:#fcc,stroke:#333
```

- **-32700**: Parse error - Invalid JSON received
- **-32600**: Invalid Request - JSON structure invalid
- **-32601**: Method not found - Method does not exist
- **-32602**: Invalid params - Invalid method parameters
- **-32603**: Internal error - Internal JSON-RPC error
- **-32000 to -32099**: Server error - Reserved for implementation-defined errors

## Communication Flow

### Single Request-Response

```mermaid
sequenceDiagram
    participant C as Client
    participant S as Server

    C->>S: {"jsonrpc":"2.0","method":"getOrder","params":{"orderId":"123"},"id":1}
    S->>C: {"jsonrpc":"2.0","result":{"orderId":"123","status":"SHIPPED"},"id":1}
```

### Batch Request

```mermaid
sequenceDiagram
    participant C as Client
    participant S as Server

    C->>S: [request1, request2, request3]
    S->>C: [response1, response2, response3]
```

Multiple requests sent as JSON array. Server may process in any order but returns all responses.

```json
[
    {"jsonrpc": "2.0", "method": "getUser", "params": {"userId": "1"}, "id": 1},
    {"jsonrpc": "2.0", "method": "getOrder", "params": {"orderId": "123"}, "id": 2},
    {"jsonrpc": "2.0", "method": "logEvent", "params": {"event": "batch_call"}}
]
```

```json
[
    {"jsonrpc": "2.0", "result": {"userId": "1", "name": "John"}, "id": 1},
    {"jsonrpc": "2.0", "result": {"orderId": "123", "status": "SHIPPED"}, "id": 2}
]
```

Notification in batch produces no response element.

## Parameter Passing

### By-Position (Array)

```json
{
    "jsonrpc": "2.0",
    "method": "subtract",
    "params": [42, 23],
    "id": 1
}
```

Parameters matched to method signature by position.

### By-Name (Object)

```json
{
    "jsonrpc": "2.0",
    "method": "subtract",
    "params": {"minuend": 42, "subtrahend": 23},
    "id": 2
}
```

Parameters matched by name, allowing flexibility in order.

## Transport Mechanisms

### HTTP POST

Most common transport. JSON-RPC messages sent as HTTP POST body.

```http
POST /rpc HTTP/1.1
Host: api.example.com
Content-Type: application/json
Content-Length: 123

{"jsonrpc":"2.0","method":"createOrder","params":{...},"id":1}
```

```http
HTTP/1.1 200 OK
Content-Type: application/json

{"jsonrpc":"2.0","result":{...},"id":1}
```

**Important:** Always return HTTP 200 for valid JSON-RPC requests, even when method execution fails. Error indicated in JSON-RPC error field.

### WebSocket

Full-duplex communication for bidirectional RPC and server-initiated notifications.

```JavaScript
const ws = new WebSocket('ws://api.example.com/rpc');

ws.onopen = () => {
    ws.send(JSON.stringify({
        jsonrpc: '2.0',
        method: 'subscribe',
        params: {topic: 'orders'},
        id: 1
    }));
};

ws.onmessage = (event) => {
    const response = JSON.parse(event.data);
    console.log(response);
};
```

### TCP/Unix Sockets

Direct socket communication for internal services.

## Implementation Examples

### JavaScript Client

```JavaScript
class JsonRpcClient {
    constructor(url) {
        this.url = url;
        this.requestId = 0;
    }

    async call(method, params) {
        const request = {
            jsonrpc: '2.0',
            method: method,
            params: params,
            id: ++this.requestId
        };

        const response = await fetch(this.url, {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(request)
        });

        const data = await response.json();

        if (data.error) {
            throw new Error(`RPC Error ${data.error.code}: ${data.error.message}`);
        }

        return data.result;
    }

    notify(method, params) {
        const notification = {
            jsonrpc: '2.0',
            method: method,
            params: params
        };

        fetch(this.url, {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(notification)
        });
    }
}

// Usage
const client = new JsonRpcClient('http://api.example.com/rpc');
const order = await client.call('createOrder', {
    userId: 'user-123',
    totalAmount: 99.99
});
```

### Python Server

```Python
from flask import Flask, request, jsonify

app = Flask(__name__)

class OrderService:
    def create_order(self, user_id, items, total_amount):
        # Business logic
        return {
            'orderId': 'ord-123',
            'status': 'CREATED',
            'createdAt': int(time.time() * 1000)
        }

    def get_order(self, order_id):
        # Fetch order
        if not order_exists(order_id):
            raise JsonRpcError(-32602, 'Order not found', {'orderId': order_id})
        return {'orderId': order_id, 'status': 'SHIPPED'}

class JsonRpcError(Exception):
    def __init__(self, code, message, data=None):
        self.code = code
        self.message = message
        self.data = data

service = OrderService()

@app.route('/rpc', methods=['POST'])
def handle_rpc():
    try:
        req = request.get_json()

        # Get method
        method_name = req.get('method')
        if not hasattr(service, method_name):
            return jsonify({
                'jsonrpc': '2.0',
                'error': {'code': -32601, 'message': 'Method not found'},
                'id': req.get('id')
            })

        # Call method
        params = req.get('params', {})
        method = getattr(service, method_name)

        if isinstance(params, dict):
            result = method(**params)
        else:
            result = method(*params)

        # Return response
        return jsonify({
            'jsonrpc': '2.0',
            'result': result,
            'id': req.get('id')
        })

    except JsonRpcError as e:
        return jsonify({
            'jsonrpc': '2.0',
            'error': {
                'code': e.code,
                'message': e.message,
                'data': e.data
            },
            'id': req.get('id')
        })
    except Exception as e:
        return jsonify({
            'jsonrpc': '2.0',
            'error': {'code': -32603, 'message': 'Internal error'},
            'id': req.get('id')
        })
```

### Java Client

```Java
public class JsonRpcClient {
    private final String url;
    private final ObjectMapper mapper = new ObjectMapper();
    private final AtomicInteger requestId = new AtomicInteger(0);

    public JsonRpcClient(String url) {
        this.url = url;
    }

    public <T> T call(String method, Object params, Class<T> resultType)
            throws IOException {
        Map<String, Object> request = new HashMap<>();
        request.put("jsonrpc", "2.0");
        request.put("method", method);
        request.put("params", params);
        request.put("id", requestId.incrementAndGet());

        HttpClient client = HttpClient.newHttpClient();
        HttpRequest httpRequest = HttpRequest.newBuilder()
            .uri(URI.create(url))
            .header("Content-Type", "application/json")
            .POST(HttpRequest.BodyPublishers.ofString(
                mapper.writeValueAsString(request)))
            .build();

        HttpResponse<String> response = client.send(httpRequest,
            HttpResponse.BodyHandlers.ofString());

        JsonNode root = mapper.readTree(response.body());
        if (root.has("error")) {
            JsonNode error = root.get("error");
            throw new JsonRpcException(
                error.get("code").asInt(),
                error.get("message").asText());
        }

        return mapper.treeToValue(root.get("result"), resultType);
    }
}

// Usage
JsonRpcClient client = new JsonRpcClient("http://api.example.com/rpc");
Map<String, Object> params = Map.of(
    "userId", "user-123",
    "totalAmount", 99.99
);
OrderResponse order = client.call("createOrder", params, OrderResponse.class);
```

## Use Cases

### Web Applications
Simple RPC for browser JavaScript to backend server communication without REST overhead.

### Blockchain Nodes
Ethereum, Bitcoin, and other blockchains expose JSON-RPC APIs for node interaction.

```JavaScript
// Ethereum JSON-RPC
const request = {
    jsonrpc: '2.0',
    method: 'eth_blockNumber',
    params: [],
    id: 1
};
```

### Microservices
Lightweight inter-service communication when binary protocols are unnecessary.

### Browser Extensions
Extension background scripts communicate with content scripts via JSON-RPC over message passing.

### Plugin Systems
Applications use JSON-RPC for plugin communication, enabling language-agnostic extensions.

## Security Considerations

### Authentication
JSON-RPC specification does not define authentication. Implement at transport layer.

```http
POST /rpc HTTP/1.1
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### Input Validation
Always validate params before method execution. Return `-32602` for invalid params.

### Rate Limiting
Implement per-client or per-IP rate limits to prevent abuse.

### Method Whitelisting
Explicitly define exposed methods. Never dynamically invoke arbitrary methods based on request.

## Advantages

- **Simplicity**: Minimal specification, quick implementation
- **Human-readable**: JSON format easy to debug
- **Universal support**: JSON parsers in every language
- **Flexibility**: Transport-agnostic design
- **Batch operations**: Efficient multiple requests

## Limitations

- **No schema**: Unlike gRPC or Thrift, no formal interface definition
- **Text overhead**: JSON larger than binary protocols
- **Limited streaming**: Not designed for streaming data
- **No built-in discovery**: Clients must know available methods
- **Performance**: Slower serialization than binary formats

## Best Practices

### Versioning
Include version in method names or use separate endpoints.

```json
{"method": "v2.createOrder", "params": {...}}
```

### Error Handling
Use custom error codes (-32000 to -32099) for application-specific errors.

```json
{
    "code": -32001,
    "message": "Insufficient funds",
    "data": {"balance": 50.00, "required": 99.99}
}
```

### Documentation
Maintain clear documentation of available methods, parameters, and return types.

### Request IDs
Use monotonically increasing integers or UUIDs for request tracking.

### Logging
Log all RPC requests and responses for debugging and auditing.

## Common Pitfalls

### Ignoring Error Codes
Always check for error field before accessing result.

### HTTP Status Confusion
Valid JSON-RPC requests return HTTP 200 even on method errors. Error details in JSON-RPC error object.

### Synchronous Blocking
Long-running methods block client. Consider async patterns or job queues for heavy operations.

### Missing Validation
Trusting client input leads to vulnerabilities. Always validate params.

***
# References
1. https://www.jsonrpc.org/specification
2. JSON-RPC 2.0 Specification - 2010
3. https://ethereum.org/en/developers/docs/apis/json-rpc/
4. Building Web APIs with JSON-RPC - 2018
5. [[Remote Procedure Call|Back to RPC Overview]]
