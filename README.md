# SSEDAP

SSE Directory Access Protocol (LDAP proxy + meta information)

# API Usage

**NOTE:** You **must** perform these requests over SSL. Posting credentials 
via plain HTTP is both insecure, and will result in an error response from 
the SSEDAP server.

The following examples assume your server is at https://ssedap.local

### Response Codes

```
200 OK           - Success!
400 Bad Request  - Not using the API via SSL
401 Unauthorized - Incorrect/missing credentials
404 Not Found    - API method not found
```

## Authenticating

### Request

```
POST /api/authorize HTTP/1.1
Host: ssedap.local
Content-Type: application/x-www-form-urlencoded
Content-Length: [length of data]

username=your_ldap_user123&password=supersecret
```

### Response

```
{
  "success": (true|false),
  "user": "your_ldap_user123",
  "user_info": {
    "somekey": "somevalue",
    ...
  },
  "error": "some text"
}

"error" will only be present when success == false.
"user_info" will only be present when success == true.
```

## Requesting information about a user

**_You must be an officer/admin to retrieve information via this method._**

**NOTE:** Requests for a user that doesn't exist will result in a 200 OK and an empty 
"user_info" dictionary.

### Request

```
POST /api/userinfo HTTP/1.1
Host: ssedap.local
Content-Type: application/x-www-form-urlencoded
Content-Length: [length of data]

username=your_ldap_user123&password=supersecret&lookup=other_ldap_user456
```

### Response

```
{
  "success": (true|false),
  "user": "your_ldap_user123",
  "lookup": "other_ldap_user456",
  "user_info": {
    "somekey": "somevalue",
    ...
  },
  "error": "some text"
}

"error" will only be present when success == false.
"user_info" will only be present when success == true.
```

