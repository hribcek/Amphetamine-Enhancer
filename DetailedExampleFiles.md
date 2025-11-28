### Detailed Example Files (For Reference)

#### **.vscode/tasks.json**
```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Build Amphetamine Enhancer",
            "type": "shell",
            "command": "xcodebuild",
            "args": [
                "-project", "Xcode Project/Amphetamine Enhancer.xcodeproj",
                "-scheme", "Amphetamine Enhancer",
                "-configuration", "Debug",
                "-derivedDataPath", "${workspaceFolder}/build",
                "build"
            ],
            "group": {
                "kind": "build",
                "isDefault": true
            },
            "presentation": {
                "reveal": "always",
                "panel": "shared"
            },
            "problemMatcher": "$xcode"
        },
        {
            "label": "Clean",
            "type": "shell",
            "command": "xcodebuild",
            "args": [
                "-project", "Xcode Project/Amphetamine Enhancer.xcodeproj",
                "clean"
            ],
            "problemMatcher": []
        }
    ]
}
````

#### **.vscode/launch.json**

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Debug App",
            "type": "lldb",
            "request": "launch",
            "program": "${workspaceFolder}/build/Build/Products/Debug/Amphetamine Enhancer.app/Contents/MacOS/Amphetamine Enhancer",
            "args": [],
            "cwd": "${workspaceFolder}",
            "preLaunchTask": "Build Amphetamine Enhancer",
            "stopOnEntry": false
        }
    ]
}
```

#### **.vscode/c\_cpp\_properties.json**

```json
{
    "configurations": [
        {
            "name": "Mac",
            "includePath": [
                "${workspaceFolder}/**"
            ],
            "defines": [],
            "macFrameworkPath": [
                "/System/Library/Frameworks",
                "/Library/Frameworks"
            ],
            "compilerPath": "/usr/bin/clang",
            "cStandard": "c11",
            "cppStandard": "c++17",
            "intelliSenseMode": "macos-clang-arm64"
        }
    ],
    "version": 4
}
```

#### **.vscode/extensions.json**

```json
{
    "recommendations": [
        "ms-vscode.cpptools",
        "vadimcn.vscode-lldb"
    ]
}
```
