import os
import html

def make_vscode_html(active_filename, file_path, code_content, breadcrumbs):
    escaped_code = html.escape(code_content)
    lines = code_content.splitlines()
    line_nums_html = "\n".join(f"<div>{i+1}</div>" for i in range(len(lines)))
    
    # Simple syntax styling for java/jsp
    code_lines_html = []
    for line in lines:
        escaped_line = html.escape(line)
        # keywords
        for kw in ["package", "import", "public", "class", "extends", "implements", "protected", "void", "throws", "new", "if", "else", "return", "int", "long", "boolean", "null", "true", "false", "@WebServlet", "@Override"]:
            escaped_line = escaped_line.replace(f"{kw} ", f'<span style="color:#569cd6;">{kw}</span> ')
        # strings
        # simple tags
        code_lines_html.append(f"<div>{escaped_line if escaped_line else '&nbsp;'}</div>")
    
    code_body_html = "\n".join(code_lines_html)
    
    html_template = f"""<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
* {{ box-sizing: border-box; margin: 0; padding: 0; user-select: none; }}
body {{
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    background-color: #1e1e1e;
    color: #cccccc;
    width: 1920px;
    height: 1080px;
    overflow: hidden;
    display: flex;
    flex-direction: column;
}}
/* Titlebar */
.titlebar {{
    height: 35px;
    background-color: #323233;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 10px;
    font-size: 12px;
    color: #cccccc;
    border-bottom: 1px solid #252526;
}}
.menu-items span {{ margin-right: 14px; cursor: pointer; }}
.window-title {{ color: #999999; font-size: 12px; font-weight: normal; }}
.window-controls span {{ display: inline-block; width: 14px; height: 14px; margin-left: 10px; border-radius: 50%; }}

/* Main Layout */
.main-container {{
    display: flex;
    flex: 1;
    overflow: hidden;
}}

/* Activity Bar */
.activity-bar {{
    width: 48px;
    background-color: #333333;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding-top: 10px;
    gap: 18px;
    border-right: 1px solid #252526;
}}
.activity-icon {{
    font-size: 22px;
    color: #858585;
    cursor: pointer;
}}
.activity-icon.active {{
    color: #ffffff;
    border-left: 2px solid #ffffff;
    padding-left: 2px;
}}

/* Sidebar Explorer */
.sidebar {{
    width: 260px;
    background-color: #252526;
    border-right: 1px solid #1e1e1e;
    font-size: 13px;
    display: flex;
    flex-direction: column;
}}
.sidebar-header {{
    padding: 8px 16px;
    text-transform: uppercase;
    font-size: 11px;
    font-weight: bold;
    color: #bbbbbb;
    letter-spacing: 0.5px;
}}
.tree-item {{
    padding: 4px 16px;
    display: flex;
    align-items: center;
    gap: 6px;
    color: #cccccc;
}}
.tree-item.folder {{ font-weight: 500; color: #e1e1e1; }}
.tree-item.active {{ background-color: #37373d; color: #ffffff; }}

/* Editor Area */
.editor-container {{
    flex: 1;
    display: flex;
    flex-direction: column;
    background-color: #1e1e1e;
    overflow: hidden;
}}
/* Tabs */
.tabs-bar {{
    height: 35px;
    background-color: #252526;
    display: flex;
    align-items: flex-end;
    overflow-x: hidden;
}}
.tab {{
    height: 35px;
    padding: 0 16px;
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 13px;
    background-color: #2d2d2d;
    color: #969696;
    border-right: 1px solid #1e1e1e;
}}
.tab.active {{
    background-color: #1e1e1e;
    color: #ffffff;
    border-top: 1px solid #007acc;
}}
.tab-close {{ font-size: 12px; margin-left: 6px; color: #999; }}

/* Breadcrumbs */
.breadcrumbs {{
    height: 22px;
    background-color: #1e1e1e;
    padding: 0 16px;
    display: flex;
    align-items: center;
    font-size: 12px;
    color: #8c8c8c;
    border-bottom: 1px solid #282828;
}}

/* Code Editor */
.code-editor {{
    flex: 1;
    display: flex;
    font-family: Consolas, "Courier New", monospace;
    font-size: 14px;
    line-height: 21px;
    overflow: hidden;
    padding-top: 6px;
}}
.line-numbers {{
    width: 60px;
    text-align: right;
    padding-right: 18px;
    color: #858585;
    user-select: none;
}}
.code-content {{
    flex: 1;
    color: #d4d4d4;
    white-space: pre;
    tab-size: 4;
}}

/* Statusbar */
.statusbar {{
    height: 22px;
    background-color: #007acc;
    color: #ffffff;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 12px;
    font-size: 12px;
}}
.statusbar-left, .statusbar-right {{ display: flex; gap: 14px; align-items: center; }}

/* Windows Taskbar */
.taskbar {{
    height: 48px;
    background-color: #f3f3f3;
    border-top: 1px solid #e5e5e5;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 12px;
}}
.taskbar-center {{
    display: flex;
    align-items: center;
    gap: 12px;
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
}}
.taskbar-icon {{
    width: 26px;
    height: 26px;
    border-radius: 4px;
}}
.taskbar-right {{
    font-size: 12px;
    color: #222;
    text-align: right;
    line-height: 1.2;
}}
</style>
</head>
<body>
    <div class="titlebar">
        <div class="menu-items">
            <span style="font-weight:bold; color:#007acc;">VS Code</span>
            <span>File</span><span>Edit</span><span>Selection</span><span>View</span><span>Go</span><span>Run</span><span>Terminal</span><span>Help</span>
        </div>
        <div class="window-title">{active_filename} - servlet-jpa-starter (24110251)</div>
        <div class="window-controls">
            <span style="background:#555;"></span><span style="background:#777;"></span><span style="background:#e81123;"></span>
        </div>
    </div>

    <div class="main-container">
        <div class="activity-bar">
            <div class="activity-icon active">📁</div>
            <div class="activity-icon">🔍</div>
            <div class="activity-icon">🌿</div>
            <div class="activity-icon">▶️</div>
            <div class="activity-icon">🧩</div>
        </div>

        <div class="sidebar">
            <div class="sidebar-header">Explorer: servlet-jpa-starter</div>
            <div class="tree-item folder">▼ src/main/java</div>
            <div class="tree-item folder" style="padding-left:26px;">▼ com.template</div>
            <div class="tree-item folder" style="padding-left:36px;">📁 controller</div>
            <div class="tree-item folder" style="padding-left:36px;">📁 dao</div>
            <div class="tree-item folder" style="padding-left:36px;">📁 entity</div>
            <div class="tree-item folder" style="padding-left:36px;">📁 filter</div>
            <div class="tree-item folder" style="padding-left:36px;">📁 service</div>
            <div class="tree-item folder">▼ src/main/webapp</div>
            <div class="tree-item folder" style="padding-left:26px;">📁 common</div>
            <div class="tree-item folder" style="padding-left:26px;">📁 decorators</div>
            <div class="tree-item folder" style="padding-left:26px;">📁 view</div>
            <div class="tree-item" style="padding-left:26px;">📄 index.jsp</div>
            <div class="tree-item active" style="padding-left:26px;">📄 {active_filename}</div>
        </div>

        <div class="editor-container">
            <div class="tabs-bar">
                <div class="tab active">
                    <span>☕ {active_filename}</span>
                    <span class="tab-close">✕</span>
                </div>
            </div>

            <div class="breadcrumbs">
                {breadcrumbs}
            </div>

            <div class="code-editor">
                <div class="line-numbers">
                    {line_nums_html}
                </div>
                <div class="code-content">
                    {code_body_html}
                </div>
            </div>
        </div>
    </div>

    <div class="statusbar">
        <div class="statusbar-left">
            <span>🌿 main*</span>
            <span>⟳ 0 ↓ 0 ↑</span>
            <span>✕ 0  ⚠ 0</span>
        </div>
        <div class="statusbar-right">
            <span>Ln 1, Col 1</span>
            <span>Spaces: 4</span>
            <span>UTF-8</span>
            <span>CRLF</span>
            <span>Java / JSP</span>
            <span>🔔</span>
        </div>
    </div>

    <div class="taskbar">
        <div style="font-size:12px; color:#555;">🔎 Type here to search</div>
        <div class="taskbar-center">
            <span style="font-size:20px;">🪟</span>
            <span style="font-size:20px;">📁</span>
            <span style="font-size:20px;">🌐</span>
            <span style="font-size:20px;">💻</span>
            <span style="font-size:20px;">📝</span>
        </div>
        <div class="taskbar-right">
            <div>ENG</div>
            <div>10:30 AM<br>9/24/2026</div>
        </div>
    </div>
</body>
</html>
"""
    return html_template

print("make_vscode_html defined")
