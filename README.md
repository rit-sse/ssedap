# SSEDAP

SSE Directory Access Protocol (LDAP proxy + meta information)

# API Usage

**NOTE:** You **must** perform these requests over SSL. Posting credentials 
via plain HTTP is both insecure, and will result in an error response from 
the SSEDAP server.

If your SSEDAP server is at `https://ssedap`, then you'd perform the following 
requests:

## Authenticating

**Request**

```
POST /authorize HTTP/1.1
Host: ssedap
Content-Type: application/x-www-form-urlencoded
Content-length: [length of data]

username=[LDAP user]&password=[LDAP password]
```

**Response**

```
{
success: (true|false),
user: [LDAP user],
error: "some text" # will only be present in the event of an error (when success==false)
}
```

## Requesting information about a user

**_You must be an officer/admin to retrieve information via this method._**

**Request**

```
POST /userinfo HTTP/1.1
Host: ssedap
Content-Type: application/x-www-form-urlencoded
Content-length: [length of data]

username=[LDAP user]&password=[LDAP password]&userToQuery=[LDAP user to look up]
```

**Response**

```
{
success: (true|false),
user: [LDAP user you're authenticating as],
queriedUser: [LDAP user you're attempting to look up],
userInfo: {
              k: "v",
              k2: "v2",   # userInfo is a JSON object with the user's meta info
              ...
          },
error: "some text" # will only be present in the event of an error (when success==false)
}
```


