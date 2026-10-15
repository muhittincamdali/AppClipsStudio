# Checking App Clip Size

Check every App Clip variant against the limit Apple applies to it, in code or in CI.

## Overview

Apple limits the uncompressed size of each App Clip variant so it launches quickly:

| Device             | Limit                                                                                       |
| ------------------ | ------------------------------------------------------------------------------------------- |
| iOS 15 and earlier | 10 MB                                                                                       |
| iOS 16             | 15 MB                                                                                       |
| iOS 17 and later   | 100 MB with the demo link, or with digital-only invocations and an iOS 17 deployment target |
|                    | 15 MB otherwise, for example with App Clip Codes, NFC tags or QR codes                      |

``SizeBudget`` applies these rules. It needs the App Clip's deployment target and how people
invoke it (``InvocationSupport``).

### Create the size report

Xcode measures each variant when you export the App Clip:

1. Archive the app that contains the App Clip and open the archive in the Organizer.
2. Click **Distribute App** and export the App Clip as an Ad Hoc or Development build with
   **App Thinning** set to **All compatible device variants**.
3. The export folder contains `App Thinning Size Report.txt`.

In CI, run `xcodebuild -exportArchive` with an export options property list whose `thinning`
key is `<thin-for-all-variants>`.

### Check the report

```sh
swift run appclipstudio size "App Thinning Size Report.txt" --deployment-target 16.0
```

```text
App Clip size check (iOS 16+, physical and digital invocations)
  ok   ExampleClip-a.ipa  14.60 MB of 15.00 MB
  OVER ExampleClip-b.ipa  15.20 MB of 15.00 MB
1 of 2 variants are over the limit.
```

The exit status is 1 when a variant is over its limit, so the command can fail a CI job. Add
`--invocations digital` or `--invocations demo` for the larger iOS 17 limit, and `--json` for
machine-readable output.

In code:

```swift
let report = try ThinningReport(parsing: text)
let budget = try SizeBudget(deploymentTarget: 16, invocations: .physical)
let evaluation = budget.evaluate(report)
for entry in evaluation.entries where !entry.isWithinLimit {
    print("\(entry.name) is \(-entry.headroomBytes) bytes over")
}
```

Each variant is checked against the limit for its own `os-version` when the report lists one;
the `Universal` variant uses the deployment target. Sizes are decimal (1 MB is 1,000,000
bytes), the unit the report uses.

### Measure a build folder

Before you export, ``BundleSizeScanner`` adds up the files of a built `.app` and lists the
largest ones:

```sh
swift run appclipstudio size DerivedData/…/MyClip.app --deployment-target 16
```

The sum of a debug or unthinned build is larger than the thinned variants that Apple checks,
so treat it as an early warning and the size report as the answer.

### Input limits

The report parser accepts plain decimal sizes only (`6.7`, `6,7`, `512`, `Zero`) with the units
bytes, KB, MB and GB, so text such as `nan`, `inf` or `1e999` is rejected instead of becoming a
size. Reports over 8 MB or with more than 4,096 variants are refused, and the folder scan stops
after 100,000 files and folders and doesn't follow symbolic links.
