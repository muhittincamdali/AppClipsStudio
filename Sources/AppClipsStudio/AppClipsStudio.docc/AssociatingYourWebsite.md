# Associating Your Website

Write the association file and entitlement entries that let your website launch the App Clip,
and pick URLs that fit in an App Clip Code.

## Overview

To support invocations from your website or from devices that run iOS 16.3 or earlier, the
system verifies the App Clip twice: the App Clip's Associated Domains entitlement names the
domain with `appclips:`, and the domain's `apple-app-site-association` file lists the App
Clip. The full app needs `applinks:` for the same domain so it can open the same URLs once it
replaces the App Clip.

### Check the entitlement entries

```sh
swift run appclipstudio check-domain appclips:appclip.example.com applinks:example.com
```

``AssociatedDomain`` follows Apple's format, `<service>:<fully qualified domain>` with an
optional `?mode=developer`, `?mode=managed` or `?mode=developer+managed`. It rejects paths,
trailing slashes, ports and unknown services, and the `*.` wildcard for `appclips`, which
Apple doesn't allow.

### Generate the association file

```sh
swift run appclipstudio aasa generate \
  --app ABCDE12345.com.example.MyApp \
  --app-clip ABCDE12345.com.example.MyApp.Clip \
  --path "/table/*" --path "/order"
```

```json
{
    "appclips": {
        "apps": ["ABCDE12345.com.example.MyApp.Clip"]
    },
    "applinks": {
        "details": [
            {
                "appIDs": ["ABCDE12345.com.example.MyApp"],
                "components": [
                    {
                        "/": "/table/*"
                    },
                    {
                        "/": "/order"
                    }
                ]
            }
        ]
    }
}
```

Serve it at `https://<domain>/.well-known/apple-app-site-association` over HTTPS without
redirects, for each domain in the entitlement. ``AssociationFile`` builds the same file in code
and refuses an App Clip identifier that isn't the app's identifier followed by a suffix.

### Validate an existing file

```sh
swift run appclipstudio aasa validate apple-app-site-association \
  --app-clip ABCDE12345.com.example.MyApp.Clip
```

``AssociationFileValidator`` reports errors that block verification (invalid JSON, a missing or
empty `appclips` service, malformed identifiers, the expected App Clip missing) and warnings: an
App Clip whose full app isn't in `applinks`, and top-level keys that Apple doesn't document,
which are often typos such as `aplinks`.

### Choose App Clip Code URLs

An App Clip Code holds a compressed URL with little capacity. ``AppClipCodeURLCheck`` reports
the URLs Apple's rules reject and the practices that make a URL more likely to fit:

```sh
swift run appclipstudio check-url https://www.example.com/products/
```

```text
https://www.example.com/products/
  suggestion: Remove the "www" subdomain if your site allows it.
  suggestion: Remove the trailing "/".
```

The rules come from Apple's "Encoding a URL in an App Clip Code": lowercase `https`, a host of
`a`–`z`, `.` and `-`, and only `a`–`z`, `A`–`Z`, `0`–`9` and `/#?=%-._,+;:&` after it. Apple's
encoder compresses the `appclip` subdomain, 156 path words such as `shop` and `menu`, and query
names `p`, `p1`, `p2`… in order better than other text. A URL without errors can still be too
long for the code; Apple's App Clip Code Generator and App Store Connect make the final call.
