# VS Code settings

VS Code allows developers to set various settings to interact with the editor's user interface and functional behavior.

It can be set for both...

- `User Settings`: Settings that apply globally to any instance of VS Code you open.
- `Workspace Settings`: Settings stored inside your workspace and only appkly when the workspace is opened.

## Common properties


### Stylistic

- `"editor.tabSize": 4`: Sets the tab size for files
- `"editor.insertSpaces": true`: Determines whether tabs are inserted as spaces
- `"editor.detectIndentation": false`: Detects and uses indentation standards based on opened file. Ignores "editor.tabSize" and "editor.insertSpaces" when set to `true`.

### Behavioral

- `"terminal.integrated.cwd": "<path to working directory>"`: Sets the default working directory for the integrated terminal.