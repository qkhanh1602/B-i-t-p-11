import os
import sys
import time
import docx
from docx.shared import Inches, Pt, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

sys.stdout.reconfigure(encoding='utf-8')

PROJECT_ROOT = r"C:\Users\User1\.gemini\antigravity\scratch\servlet-jpa-starter"
SHOTS_DIR = r"C:\Users\User1\Desktop\screenshots_exam"
TARGET_DOCX = r"C:\Users\User1\Desktop\24110251.docx"
TEMP_DIR = os.path.join(PROJECT_ROOT, "temp_html")
os.makedirs(TEMP_DIR, exist_ok=True)
os.makedirs(SHOTS_DIR, exist_ok=True)

def read_file(rel_path):
    p = os.path.join(PROJECT_ROOT, rel_path)
    if os.path.exists(p):
        with open(p, 'r', encoding='utf-8', errors='replace') as f:
            return f.read()
    return f"// Not found: {rel_path}"

def generate_vscode_mockups():
    print("Generating VS Code HTML mockups and capturing screenshots...")
    from vscode_renderer import make_vscode_html
    
    files_to_render = [
        ("LoginController_24110251.java", "src/main/java/com/template/controller/LoginController_24110251.java", "src > main > java > com > template > controller > LoginController_24110251.java", "vscode_login_controller.png"),
        ("LogoutController_24110251.java", "src/main/java/com/template/controller/LogoutController_24110251.java", "src > main > java > com > template > controller > LogoutController_24110251.java", "vscode_logout_controller.png"),
        ("RegisterController_24110251.java", "src/main/java/com/template/controller/RegisterController_24110251.java", "src > main > java > com > template > controller > RegisterController_24110251.java", "vscode_register_controller.png"),
        ("VideoServiceImpl_24110251.java", "src/main/java/com/template/service/VideoServiceImpl_24110251.java", "src > main > java > com > template > service > VideoServiceImpl_24110251.java", "vscode_video_service.png"),
        ("detail.jsp", "src/main/webapp/view/web/detail.jsp", "src > main > webapp > view > web > detail.jsp", "vscode_video_detail_jsp.png"),
        ("HomeController_24110251.java", "src/main/java/com/template/controller/HomeController_24110251.java", "src > main > java > com > template > controller > HomeController_24110251.java", "vscode_home_controller.png"),
        ("home.jsp", "src/main/webapp/view/web/home.jsp", "src > main > webapp > view > web > home.jsp", "vscode_home_jsp.png"),
        ("Project Structure", "src/main/java/com/template/controller/HomeController_24110251.java", "src > main > java > com > template > [controllers, entity, configs, services]", "vscode_tree_overview.png")
    ]
    
    options = Options()
    options.add_argument('--headless=new')
    options.add_argument('--disable-gpu')
    options.add_argument('--window-size=1920,1080')
    driver = webdriver.Chrome(options=options)
    
    try:
        for fname, rel_path, breadcrumbs, out_img in files_to_render:
            code = read_file(rel_path)
            html_content = make_vscode_html(fname, rel_path, code, breadcrumbs)
            html_path = os.path.join(TEMP_DIR, f"{out_img}.html")
            with open(html_path, 'w', encoding='utf-8') as f:
                f.write(html_content)
            
            driver.get(f"file:///{html_path.replace(os.sep, '/')}")
            time.sleep(0.5)
            img_out_path = os.path.join(SHOTS_DIR, out_img)
            driver.save_screenshot(img_out_path)
            print(f"Captured {out_img}")
            
        # Capture page 2 of home
        try:
            # Login first to get session
            from selenium.webdriver.common.by import By
            driver.get("http://localhost:8080/servlet-jpa-starter/login")
            driver.find_element(By.NAME, 'username').send_keys('admin')
            driver.find_element(By.NAME, 'password').send_keys('123456')
            driver.find_element(By.CSS_SELECTOR, 'button[type=submit]').click()
            time.sleep(1)
            
            # Request home page 2
            driver.get("http://localhost:8080/servlet-jpa-starter/home?page_1=2")
            time.sleep(1)
            driver.save_screenshot(os.path.join(SHOTS_DIR, "cau4_5_user_home_p2.png"))
            print("Captured cau4_5_user_home_p2.png")
        except Exception as e:
            print("Page 2 capture note:", e)
            
    finally:
        driver.quit()

def build_simple_word():
    print("Building simple Word document like sample...")
    doc = docx.Document()
    
    # Page setup - standard 1 inch margins
    sections = doc.sections
    for section in sections:
        section.top_margin = Inches(0.8)
        section.bottom_margin = Inches(0.8)
        section.left_margin = Inches(0.8)
        section.right_margin = Inches(0.8)
        
    def add_p(text, bold=False, size=11, space_before=2, space_after=2):
        p = doc.add_paragraph()
        p.paragraph_format.space_before = Pt(space_before)
        p.paragraph_format.space_after = Pt(space_after)
        p.paragraph_format.line_spacing = 1.15
        run = p.add_run(text)
        run.bold = bold
        run.font.name = "Times New Roman"
        run.font.size = Pt(size)
        run.font.color.rgb = RGBColor(0, 0, 0)
        return p

    def add_img(img_name):
        path = os.path.join(SHOTS_DIR, img_name)
        if not os.path.exists(path):
            print("Warning: Missing image", path)
            return
        p = doc.add_paragraph()
        p.paragraph_format.space_before = Pt(4)
        p.paragraph_format.space_after = Pt(2)
        run = p.add_run()
        run.add_picture(path, width=Inches(6.8))

    # Header block
    add_p("Họ và Tên : Nguyễn Quốc Khánh", bold=True, size=13)
    add_p("Mssv: 24110251", bold=True, size=13)
    add_p("Môn học / Đề số: Lập trình Web - Đề số 03", bold=True, size=13, space_after=8)

    # Câu 1
    add_p("Câu 1 :", bold=True, size=13, space_before=10, space_after=4)
    add_img("vscode_tree_overview.png")
    add_p("controllers, entity, configs, services", size=11, space_after=6)
    add_img("cau4_5_user_home.png")
    add_p("Header/Footer trên trang chủ", size=11, space_after=8)

    # Câu 2
    add_p("Câu 2", bold=True, size=13, space_before=10, space_after=4)
    add_img("cau2_login.png")
    add_p("Màn hình giao diện đăng nhập", size=11, space_after=6)
    
    add_img("vscode_login_controller.png")
    add_p("LoginController_24110251.java", size=11, space_after=6)
    
    add_img("vscode_logout_controller.png")
    add_p("LogoutController_24110251.java", size=11, space_after=6)
    
    add_img("cau2_register.png")
    add_p("Giao diện trang Đăng ký", size=11, space_after=6)
    
    add_img("cau2_otp.png")
    add_p("Giao diện trang Nhập mã OTP", size=11, space_after=6)
    
    add_img("vscode_register_controller.png")
    add_p("RegisterController_24110251.java", size=11, space_after=6)
    
    add_img("cau2_crud_video_list.png")
    add_p("Bảng danh sách quản lý video (hiển thị phân trang 6 video/trang)", size=11, space_after=6)
    
    add_img("cau2_crud_video_new.png")
    add_p("Giao diện form thêm mới", size=11, space_after=6)
    
    add_img("vscode_video_service.png")
    add_p("VideoServiceImpl_24110251.java", size=11, space_after=8)

    # Câu 3
    add_p("Câu 3 :", bold=True, size=13, space_before=10, space_after=4)
    add_img("cau3_video_detail.png")
    add_p("Trang chi tiết hiển thị Poster, Tiêu đề, Mã video, Category ID, View, Like/Share(10) và Description.", size=11, space_after=6)
    add_img("vscode_video_detail_jsp.png")
    add_p("video-detail.jsp", size=11, space_after=8)

    # Câu 4 và Câu 5
    add_p("Câu 4 và Câu 5 :", bold=True, size=13, space_before=10, space_after=4)
    add_img("cau4_5_user_home.png")
    # If p2 exists, add it, else repeat or show
    p2_img = "cau4_5_user_home_p2.png" if os.path.exists(os.path.join(SHOTS_DIR, "cau4_5_user_home_p2.png")) else "cau4_5_user_home.png"
    add_img(p2_img)
    add_p("Trang chủ cho thấy tên các danh mục đi kèm số lượng video được đếm tự động, danh sách video dạng lưới và các nút phân trang (3 video/trang).", size=11, space_after=6)
    add_img("vscode_home_controller.png")
    add_p("HomeController_24110251.java", size=11, space_after=6)
    add_img("vscode_home_jsp.png")
    add_p("home.jsp", size=11, space_after=8)

    doc.save(TARGET_DOCX)
    print(f"Successfully saved simple Word report to {TARGET_DOCX}!")

if __name__ == "__main__":
    generate_vscode_mockups()
    build_simple_word()
