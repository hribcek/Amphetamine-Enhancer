### Agent Instructions

**Goal:** Configure the `Amphetamine Enhancer` Xcode repository for development within Visual Studio Code.

**Project Context:**
* **Repository:** `https://github.com/hribcek/Amphetamine-Enhancer`
* **Type:** macOS Application (Cocoa)
* **Language:** Objective-C (primary)
* **Build System:** Xcode (`.xcodeproj`) inside the `Xcode Project/` folder.

**Instructions for the Agent:**

1.  **Analyze the Project Structure**:
    * Locate the `.xcodeproj` file. **Note:** In this repository, it is located inside the `Xcode Project/` subfolder, not the root.
    * Identify the main **Scheme** (usually `Amphetamine Enhancer`) and the **Build Target**.

2.  **Create VS Code Configuration (`.vscode` folder)**:
    * Create a `.vscode` directory in the root of the project (if it doesn't exist).

3.  **Generate `tasks.json` (Build System)**:
    * Create a `.vscode/tasks.json` file.
    * Define a "Build" task that runs `xcodebuild`.
    * **Critical Path:** Ensure the `-project` argument points to `"Xcode Project/Amphetamine Enhancer.xcodeproj"`.
    * **Critical Output:** You must include the argument `-derivedDataPath "${workspaceFolder}/build"` so that build artifacts are stored locally.
    * Define a "Clean" task that runs `xcodebuild clean`.
    * *Constraint:* Ensure the build task is marked as the "default build task".

4.  **Generate `launch.json` (Debugging)**:
    * Create a `.vscode/launch.json` file.
    * Configure it to use the **CodeLLDB** debugger (type: `lldb`).
    * Set the `program` path to the binary inside the built `.app` bundle. Based on the derived data path, the structure must be:
        `${workspaceFolder}/build/Build/Products/Debug/Amphetamine Enhancer.app/Contents/MacOS/Amphetamine Enhancer`
    * Add a `preLaunchTask` pointing to the "Build" task created in step 3.

5.  **Configure IntelliSense (`c_cpp_properties.json`)**:
    * Create `.vscode/c_cpp_properties.json`.
    * Set `compilerPath` to `/usr/bin/clang`.
    * Set `macFrameworkPath` to standard macOS frameworks.
    * Ensure `includePath` covers the project root.

6.  **Extension Recommendations**:
    * Create a `.vscode/extensions.json` file.
    * Recommend: `ms-vscode.cpptools` (C/C++), `vadimcn.vscode-lldb` (CodeLLDB).

7.  **Git Ignore Update**:
    * Check `.gitignore` in the root.
    * Ensure the following are ignored: `.vscode/`, `build/`, and `DerivedData/`.
