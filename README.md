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
Content-length: [length of data]

username=your_ldap_user123&password=supersecret
```

### Response

```
{
  "success": (true|false),
  "user": "your_ldap_user123",
  "error": "some text" # will only be present in the event of an error (when success==false)
}
```

## Requesting information about a user

**_You must be an officer/admin to retrieve information via this method._**

### Request

```
POST /api/userinfo HTTP/1.1
Host: ssedap.local
Content-Type: application/x-www-form-urlencoded
Content-length: [length of data]

username=your_ldap_user123&password=supersecret&lookupUser=other_ldap_user456
```

### Response

```
{
  "success": (true|false),
  "user": "your_ldap_user123",
  "queriedUser": "other_ldap_user456",
  "userInfo": {
                "somekey": "somevalue",     # userInfo = JSON object with the user's meta info,
                ...                         # and is only present if success==true
              },
  "error": "some text"                      # will only be present in the event of an error (when success==false)
}
```


