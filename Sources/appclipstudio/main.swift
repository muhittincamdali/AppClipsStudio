import AppClipsStudioTool
import Foundation

let result = Tool.run(Array(CommandLine.arguments.dropFirst()))
FileHandle.standardOutput.write(Data(result.standardOutput.utf8))
FileHandle.standardError.write(Data(result.standardError.utf8))
exit(result.exitCode)
