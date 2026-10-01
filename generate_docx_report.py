import os
import sys
import docx
from docx.shared import Inches, Pt, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.enum.table import WD_TABLE_ALIGNMENT, WD_ALIGN_VERTICAL
from docx.oxml import OxmlElement, parse_xml
from docx.oxml.ns import nsdecls, qn

sys.stdout.reconfigure(encoding='utf-8')

PROJECT_ROOT = r"C:\Users\User1\.gemini\antigravity\scratch\servlet-jpa-starter"
SHOTS_DIR = r"C:\Users\User1\Desktop\screenshots_exam"
TARGET_DOCX = r"C:\Users\User1\Desktop\24110251.docx"

def read_file(rel_path):
    full_path = os.path.join(PROJECT_ROOT, rel_path)
    if os.path.exists(full_path):
        with open(full_path, 'r', encoding='utf-8', errors='replace') as f:
            return f.read()
    return f"// File not found: {rel_path}"

def set_cell_background(cell, fill_hex):
    tcPr = cell._tc.get_or_add_tcPr()
    tcPr.append(parse_xml(f'<w:shd {nsdecls("w")} w:fill="{fill_hex}"/>'))

def set_cell_margins(cell, top=100, bottom=100, left=150, right=150):
    tcPr = cell._tc.get_or_add_tcPr()
    tcMar = OxmlElement('w:tcMar')
    for m, val in [('w:top', top), ('w:bottom', bottom), ('w:left', left), ('w:right', right)]:
        node = OxmlElement(m)
        node.set(qn('w:w'), str(val))
        node.set(qn('w:type'), 'dxa')
        tcMar.append(node)
    tcPr.append(tcMar)

def add_callout(doc, text_list, title=None, fill_hex="F0F4F8", border_color="003366"):
    tbl = doc.add_table(rows=1, cols=1)
    tbl.alignment = WD_TABLE_ALIGNMENT.CENTER
    cell = tbl.cell(0, 0)
    set_cell_background(cell, fill_hex)
    set_cell_margins(cell, top=120, bottom=120, left=180, right=180)
    
    tcPr = cell._tc.get_or_add_tcPr()
    borders = parse_xml(
        f'<w:tcBorders {nsdecls("w")}>\n'
        f'  <w:top w:val="none"/>\n'
        f'  <w:left w:val="single" w:sz="24" w:space="0" w:color="{border_color}"/>\n'
        f'  <w:bottom w:val="none"/>\n'
        f'  <w:right w:val="none"/>\n'
        f'</w:tcBorders>'
    )
    tcPr.append(borders)
    
    p = cell.paragraphs[0]
    p.paragraph_format.space_before = Pt(2)
    p.paragraph_format.space_after = Pt(2)
    p.paragraph_format.line_spacing = 1.15
    if title:
        run_title = p.add_run(title + "\n")
        run_title.bold = True
        run_title.font.name = "Calibri"
        run_title.font.size = Pt(11)
        run_title.font.color.rgb = RGBColor(0x00, 0x33, 0x66)
    
    for i, line in enumerate(text_list):
        if i > 0 or title:
            p2 = cell.add_paragraph()
            p2.paragraph_format.space_before = Pt(1)
            p2.paragraph_format.space_after = Pt(2)
            p2.paragraph_format.line_spacing = 1.15
            run = p2.add_run(line)
        else:
            run = p.add_run(line)
        run.font.name = "Calibri"
        run.font.size = Pt(10.5)
        run.font.color.rgb = RGBColor(0x22, 0x22, 0x22)
    
    doc.add_paragraph().paragraph_format.space_after = Pt(4)

def add_code_block(doc, title, code_snippet, max_lines=45):
    p_title = doc.add_paragraph()
    p_title.paragraph_format.space_before = Pt(8)
    p_title.paragraph_format.space_after = Pt(2)
    p_title.paragraph_format.keep_with_next = True
    r_icon = p_title.add_run("💻 Code: ")
    r_icon.bold = True
    r_icon.font.name = "Calibri"
    r_icon.font.size = Pt(10.5)
    r_icon.font.color.rgb = RGBColor(0x1A, 0x52, 0x76)
    
    r_title = p_title.add_run(title)
    r_title.bold = True
    r_title.font.name = "Consolas"
    r_title.font.size = Pt(10)
    r_title.font.color.rgb = RGBColor(0x8E, 0x44, 0xAD)

    lines = code_snippet.strip().splitlines()
    if len(lines) > max_lines:
        snippet_text = "\n".join(lines[:max_lines]) + f"\n... [đã rút gọn {len(lines) - max_lines} dòng tiếp theo]"
    else:
        snippet_text = "\n".join(lines)
    
    tbl = doc.add_table(rows=1, cols=1)
    tbl.alignment = WD_TABLE_ALIGNMENT.CENTER
    cell = tbl.cell(0, 0)
    set_cell_background(cell, "F8F9FA")
    set_cell_margins(cell, top=100, bottom=100, left=150, right=150)
    
    tcPr = cell._tc.get_or_add_tcPr()
    borders = parse_xml(
        f'<w:tcBorders {nsdecls("w")}>\n'
        f'  <w:top w:val="single" w:sz="6" w:space="0" w:color="CCCCCC"/>\n'
        f'  <w:left w:val="single" w:sz="18" w:space="0" w:color="4A90E2"/>\n'
        f'  <w:bottom w:val="single" w:sz="6" w:space="0" w:color="CCCCCC"/>\n'
        f'  <w:right w:val="single" w:sz="6" w:space="0" w:color="CCCCCC"/>\n'
        f'</w:tcBorders>'
    )
    tcPr.append(borders)
    
    p = cell.paragraphs[0]
    p.paragraph_format.space_before = Pt(2)
    p.paragraph_format.space_after = Pt(2)
    p.paragraph_format.line_spacing = 1.05
    run = p.add_run(snippet_text)
    run.font.name = "Consolas"
    run.font.size = Pt(9)
    run.font.color.rgb = RGBColor(0x24, 0x29, 0x2E)
    
    doc.add_paragraph().paragraph_format.space_after = Pt(4)

def add_heading_1(doc, text):
    h = doc.add_paragraph()
    h.paragraph_format.space_before = Pt(18)
    h.paragraph_format.space_after = Pt(4)
    h.paragraph_format.keep_with_next = True
    run = h.add_run(text)
    run.bold = True
    run.font.name = "Calibri"
    run.font.size = Pt(14)
    run.font.color.rgb = RGBColor(0x00, 0x33, 0x66)
    
    p_line = doc.add_paragraph()
    p_line.paragraph_format.space_before = Pt(0)
    p_line.paragraph_format.space_after = Pt(6)
    r_line = p_line.add_run("―" * 55)
    r_line.font.color.rgb = RGBColor(0xBD, 0xC3, 0xC7)
    r_line.font.size = Pt(8)

def add_heading_2(doc, text):
    h = doc.add_paragraph()
    h.paragraph_format.space_before = Pt(12)
    h.paragraph_format.space_after = Pt(3)
    h.paragraph_format.keep_with_next = True
    run = h.add_run(text)
    run.bold = True
    run.font.name = "Calibri"
    run.font.size = Pt(12)
    run.font.color.rgb = RGBColor(0x1B, 0x4F, 0x72)

def add_heading_3(doc, text):
    h = doc.add_paragraph()
    h.paragraph_format.space_before = Pt(8)
    h.paragraph_format.space_after = Pt(2)
    h.paragraph_format.keep_with_next = True
    run = h.add_run(text)
    run.bold = True
    run.font.italic = True
    run.font.name = "Calibri"
    run.font.size = Pt(11)
    run.font.color.rgb = RGBColor(0x28, 0x74, 0xA6)

def add_image_figure(doc, img_name, caption):
    img_path = os.path.join(SHOTS_DIR, img_name)
    if not os.path.exists(img_path):
        print(f"Warning: Image {img_path} not found.")
        return
    p_img = doc.add_paragraph()
    p_img.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p_img.paragraph_format.space_before = Pt(8)
    p_img.paragraph_format.space_after = Pt(2)
    run_img = p_img.add_run()
    run_img.add_picture(img_path, width=Inches(6.2))
    
    p_cap = doc.add_paragraph()
    p_cap.alignment = WD_ALIGN_PARAGRAPH.CENTER
    p_cap.paragraph_format.space_before = Pt(1)
    p_cap.paragraph_format.space_after = Pt(10)
    r_cap_lbl = p_cap.add_run("📸 Hình: ")
    r_cap_lbl.bold = True
    r_cap_lbl.font.italic = True
    r_cap_lbl.font.size = Pt(9.5)
    r_cap_lbl.font.color.rgb = RGBColor(0x44, 0x44, 0x44)
    
    r_cap = p_cap.add_run(caption)
    r_cap.font.italic = True
    r_cap.font.size = Pt(9.5)
    r_cap.font.color.rgb = RGBColor(0x44, 0x44, 0x44)

def build_report():
    print("Opening existing docx...")
    doc = docx.Document(TARGET_DOCX)
    
    # Check existing paragraphs and ensure title block is clean and prominent
    print("Formatting student header block...")
    # Add a visual separator or styled info box
    add_callout(doc, [
        "Trường Đại Học Sư Phạm Kỹ Thuật TP. Hồ Chí Minh (HCMUTE)",
        "Khoa Công Nghệ Thông Tin - Bộ Môn Công Nghệ Phần Mềm",
        "Môn thi: Lập Trình Web - Đề số 03 (Thời gian: 180 phút)",
        "Giáo viên ra đề: ThS. Nguyễn Hữu Trung",
        "Sinh viên thực hiện: NGUYỄN QUỐC KHÁNH",
        "Mã số sinh viên (MSSV): 24110251",
        "Mã đề thi: ĐỀ SỐ 03"
    ], title="BÁO CÁO KẾT QUẢ BÀI THI QUÁ TRÌNH LẬP TRÌNH WEB (JPA + SERVLET + JSP)", fill_hex="EBF5FB", border_color="1A5276")

    # Table of question summary
    tbl_sum = doc.add_table(rows=7, cols=3)
    tbl_sum.alignment = WD_TABLE_ALIGNMENT.CENTER
    headers = ["Câu hỏi", "Yêu cầu trọng tâm", "Trạng thái"]
    for j, h in enumerate(headers):
        cell = tbl_sum.cell(0, j)
        set_cell_background(cell, "1A5276")
        set_cell_margins(cell, 80, 80, 100, 100)
        p = cell.paragraphs[0]
        run = p.add_run(h)
        run.bold = True
        run.font.color.rgb = RGBColor(0xFF, 0xFF, 0xFF)
        run.font.size = Pt(9.5)
    
    sum_data = [
        ("Câu 1 (1.5đ)", "Mô hình 3 lớp (MVC, Service, DAO), Sitemesh Decorator User & Admin, Header menu & Footer MSSV", "Hoàn thành 100%"),
        ("Câu 2 (1.5đ)", "Đăng ký OTP kích hoạt, Đăng nhập, Đăng xuất Session, Phân quyền Admin / User", "Hoàn thành 100%"),
        ("Câu 2 (2.5đ)", "CRUD quản trị Videos (Tạo, xem, sửa, xóa) phân trang 6 video/trang", "Hoàn thành 100%"),
        ("Câu 3 (1.5đ)", "Trang chi tiết 1 video: Poster, Tiêu đề, Mã video, Category, View, Share, Like, Desc", "Hoàn thành 100%"),
        ("Câu 4 (2.5đ)", "Trang home User hiển thị video theo từng category phân trang 3 video/trang (<< 1 2 3 >>)", "Hoàn thành 100%"),
        ("Câu 5 (0.5đ)", "Đếm số lượng video theo từng Category hiển thị ở câu 4: Category Name (20)", "Hoàn thành 100%")
    ]
    for i, row in enumerate(sum_data):
        for j, val in enumerate(row):
            cell = tbl_sum.cell(i + 1, j)
            bg = "F2F4F4" if i % 2 == 0 else "FFFFFF"
            set_cell_background(cell, bg)
            set_cell_margins(cell, 60, 60, 100, 100)
            p = cell.paragraphs[0]
            run = p.add_run(val)
            run.font.size = Pt(9)
            if j == 2:
                run.bold = True
                run.font.color.rgb = RGBColor(0x19, 0x6F, 0x3D)

    doc.add_paragraph().paragraph_format.space_after = Pt(8)

    # =========================================================================
    # CÂU 1
    # =========================================================================
    add_heading_1(doc, "CÂU 1 (1.5 ĐIỂM): CẤU TRÚC DỰ ÁN 03 LỚP & THIẾT LẬP SITEMESH DECORATOR")
    
    add_callout(doc, [
        "• Xây dựng cấu trúc Project theo chuẩn mô hình 03 lớp:",
        "    + Presentation Layer (MVC / Controller): com.template.controller, view JSP.",
        "    + Business Layer (Services): com.template.service (Interfaces & Implementations).",
        "    + Data Access Layer (DAO): com.template.dao (Interfaces & Implementations với JPA EntityManager).",
        "• Thiết lập SiteMesh 3 Decorators cho 02 vai trò User (/* -> /decorators/web.jsp) và Admin (/admin/* -> /decorators/admin.jsp).",
        "• Menu Header chuẩn đề: [Trang Chủ] | [Sản phẩm] | [Đăng nhập] | [Trang quản trị (chỉ Admin mới có)] | [Đăng xuất].",
        "• Phần Footer đầy đủ thông tin: Họ tên: Nguyễn Quốc Khánh | MSSV: 24110251 | Mã đề: Đề số 03."
    ], title="Yêu cầu đề bài:")

    add_heading_2(doc, "1.1. Data Access Layer (DAO / Repository)")
    add_code_block(doc, "ICategoryDao_24110251.java", read_file("src/main/java/com/template/dao/ICategoryDao_24110251.java"), max_lines=25)
    add_code_block(doc, "CategoryDaoImpl_24110251.java", read_file("src/main/java/com/template/dao/CategoryDaoImpl_24110251.java"), max_lines=40)

    add_heading_2(doc, "1.2. Business Layer (Services)")
    add_code_block(doc, "ICategoryService_24110251.java", read_file("src/main/java/com/template/service/ICategoryService_24110251.java"), max_lines=25)
    add_code_block(doc, "CategoryServiceImpl_24110251.java", read_file("src/main/java/com/template/service/CategoryServiceImpl_24110251.java"), max_lines=35)

    add_heading_2(doc, "1.3. Cấu hình SiteMesh 3 Filter & Decorators")
    add_code_block(doc, "MySiteMeshFilter_24110251.java (Định tuyến Decorators User & Admin)", read_file("src/main/java/com/template/filter/MySiteMeshFilter_24110251.java"), max_lines=30)
    add_code_block(doc, "web.xml (Đăng ký SiteMeshFilter và EncodingFilter UTF-8)", read_file("src/main/webapp/WEB-INF/web.xml"), max_lines=35)

    add_heading_2(doc, "1.4. Views - Decorator Web, Admin, Header & Footer")
    add_callout(doc, [
        "Header định nghĩa menu theo đúng đề bài: Trang Chủ, Sản phẩm, Đăng nhập, Trang quản trị (phân quyền chỉ Admin mới hiển thị), và nút Đăng xuất trực tiếp.",
        "Footer hiển thị: Họ và tên: Nguyễn Quốc Khánh - MSSV: 24110251 - Mã đề: Đề số 03."
    ], title="Mô tả thành phần giao diện dùng chung:")
    add_code_block(doc, "common/web/header.jsp (Menu Header theo đề thi)", read_file("src/main/webapp/common/web/header.jsp"), max_lines=45)
    add_code_block(doc, "common/web/footer.jsp (Footer thông tin Nguyễn Quốc Khánh - MSSV 24110251 - Đề số 03)", read_file("src/main/webapp/common/web/footer.jsp"), max_lines=30)
    add_code_block(doc, "decorators/web.jsp (SiteMesh Decorator User)", read_file("src/main/webapp/decorators/web.jsp"), max_lines=35)
    add_code_block(doc, "decorators/admin.jsp (SiteMesh Decorator Admin với Sidebar)", read_file("src/main/webapp/decorators/admin.jsp"), max_lines=35)

    # =========================================================================
    # CÂU 2 (1.5đ): AUTH + OTP
    # =========================================================================
    add_heading_1(doc, "CÂU 2 (1.5 ĐIỂM): ĐĂNG KÝ KÍCH HOẠT OTP, ĐĂNG NHẬP, ĐĂNG XUẤT VỚI SESSION")
    add_callout(doc, [
        "• Luồng hoạt động: Khởi chạy dự án -> Chuyển hướng tới trang Đăng nhập (/login).",
        "• Đăng ký tài khoản mới: Điền Form đăng ký -> Hệ thống gửi mã OTP 6 số qua Email (EmailUtil) -> Chuyển sang trang /otp để nhập mã kích hoạt (Active tài khoản).",
        "• Đăng nhập: Kiểm tra username, password và trạng thái active. Lưu thông tin User vào Session (currentUser).",
        "• Phân quyền chuyển hướng: Nếu là Admin (admin=true) -> Vào trang chủ Quản trị (/admin/home); Nếu là User bình thường -> Vào trang chủ (/home); Nếu sai tài khoản -> Báo lỗi và quay lại trang đăng nhập.",
        "• Đăng xuất: Huỷ Session bằng session.invalidate() và điều hướng về /login."
    ], title="Yêu cầu đề bài & Phân tích giải thuật:")

    add_heading_2(doc, "2.1. Data Access Layer (User DAO / Repository)")
    add_code_block(doc, "IUserDao_24110251.java", read_file("src/main/java/com/template/dao/IUserDao_24110251.java"), max_lines=25)
    add_code_block(doc, "UserDaoImpl_24110251.java (Truy vấn JPA / JPQL kiểm tra tài khoản, kích hoạt OTP)", read_file("src/main/java/com/template/dao/UserDaoImpl_24110251.java"), max_lines=45)

    add_heading_2(doc, "2.2. Business Layer (User Service & Email Util)")
    add_code_block(doc, "IUserService_24110251.java", read_file("src/main/java/com/template/service/IUserService_24110251.java"), max_lines=25)
    add_code_block(doc, "UserServiceImpl_24110251.java (Logic đăng ký, đăng nhập, kích hoạt OTP)", read_file("src/main/java/com/template/service/UserServiceImpl_24110251.java"), max_lines=45)
    add_code_block(doc, "EmailUtil_24110251.java (Tiện ích sinh mã ngẫu nhiên và gửi OTP qua Email)", read_file("src/main/java/com/template/util/EmailUtil_24110251.java"), max_lines=35)

    add_heading_2(doc, "2.3. Presentation Layer (Controllers / Servlets)")
    add_code_block(doc, "RegisterController_24110251.java (Xử lý Đăng ký)", read_file("src/main/java/com/template/controller/RegisterController_24110251.java"), max_lines=45)
    add_code_block(doc, "OtpController_24110251.java (Xử lý Xác thực OTP)", read_file("src/main/java/com/template/controller/OtpController_24110251.java"), max_lines=45)
    add_code_block(doc, "LoginController_24110251.java (Xử lý Đăng nhập, Session & Điều hướng vai trò)", read_file("src/main/java/com/template/controller/LoginController_24110251.java"), max_lines=45)
    add_code_block(doc, "LogoutController_24110251.java (Xử lý Đăng xuất và Xóa Session)", read_file("src/main/java/com/template/controller/LogoutController_24110251.java"), max_lines=30)

    add_heading_2(doc, "2.4. Views (JSP Layer)")
    add_code_block(doc, "view/web/login.jsp (Giao diện đăng nhập)", read_file("src/main/webapp/view/web/login.jsp"), max_lines=40)
    add_code_block(doc, "view/web/register.jsp (Giao diện đăng ký)", read_file("src/main/webapp/view/web/register.jsp"), max_lines=40)
    add_code_block(doc, "view/web/otp.jsp (Giao diện xác thực mã OTP)", read_file("src/main/webapp/view/web/otp.jsp"), max_lines=40)

    add_heading_2(doc, "2.5. Kết quả thực nghiệm Câu 2 (Hình ảnh Chụp Toàn Màn Hình)")
    add_image_figure(doc, "cau2_login.png", "Giao diện Đăng nhập hệ thống (/login) với đầy đủ thông tin đề thi và liên kết Đăng ký")
    add_image_figure(doc, "cau2_register.png", "Giao diện Đăng ký tài khoản mới (/register)")
    add_image_figure(doc, "cau2_otp.png", "Giao diện Nhập mã xác thực OTP gửi qua Email (/otp) để kích hoạt tài khoản")
    add_image_figure(doc, "cau2_admin_home.png", "Giao diện Trang chủ Quản trị (/admin/home) sau khi đăng nhập thành công với vai trò Admin")
    add_image_figure(doc, "cau2_logged_out.png", "Thông báo Đăng xuất thành công sau khi nhấn nút Đăng xuất, Session được dọn dẹp")

    # =========================================================================
    # CÂU 2 (2.5đ): CRUD VIDEO PHÂN TRANG 6
    # =========================================================================
    add_heading_1(doc, "CÂU 2 (2.5 ĐIỂM): QUẢN TRỊ DỮ LIỆU BẢNG VIDEOS (CRUD) PHÂN TRANG 6 VIDEO/TRANG")
    add_callout(doc, [
        "• Xây dựng đầy đủ 4 thao tác CRUD trên bảng Videos:",
        "    + Create: Thêm video mới với đầy đủ thông tin (Mã video, Tiêu đề, Poster, Danh mục, Trạng thái, Mô tả).",
        "    + Read: Xem danh sách video dạng bảng dữ liệu quản trị.",
        "    + Update: Chỉnh sửa thông tin video đã có.",
        "    + Delete: Xóa video khỏi CSDL (có xử lý toàn vẹn dữ liệu).",
        "• Phân trang danh sách video: Cố định đúng 6 video trên 01 trang theo yêu cầu đề bài.",
        "• Thuật toán JPQL phân trang: .setFirstResult((page - 1) * 6).setMaxResults(6)."
    ], title="Yêu cầu đề bài & Phân tích giải thuật:")

    add_heading_2(doc, "3.1. Data Access Layer (Video DAO / Repository)")
    add_code_block(doc, "IVideoDao_24110251.java", read_file("src/main/java/com/template/dao/IVideoDao_24110251.java"), max_lines=30)
    add_code_block(doc, "VideoDaoImpl_24110251.java (CRUD & JPQL Phân trang 6 video/trang)", read_file("src/main/java/com/template/dao/VideoDaoImpl_24110251.java"), max_lines=50)

    add_heading_2(doc, "3.2. Business Layer (Video Service)")
    add_code_block(doc, "IVideoService_24110251.java", read_file("src/main/java/com/template/service/IVideoService_24110251.java"), max_lines=30)
    add_code_block(doc, "VideoServiceImpl_24110251.java", read_file("src/main/java/com/template/service/VideoServiceImpl_24110251.java"), max_lines=45)

    add_heading_2(doc, "3.3. Presentation Layer (AdminVideoController)")
    add_code_block(doc, "AdminVideoController_24110251.java (Điều phối CRUD và phân trang 6 video)", read_file("src/main/java/com/template/controller/AdminVideoController_24110251.java"), max_lines=50)

    add_heading_2(doc, "3.4. Views (JSP Quản Trị Videos)")
    add_code_block(doc, "view/admin/video-list.jsp (Bảng danh sách video có phân trang 6/trang)", read_file("src/main/webapp/view/admin/video-list.jsp"), max_lines=45)
    add_code_block(doc, "view/admin/video-form.jsp (Form tạo mới & cập nhật video)", read_file("src/main/webapp/view/admin/video-form.jsp"), max_lines=45)

    add_heading_2(doc, "3.5. Kết quả thực nghiệm CRUD Video (Hình ảnh Chụp Toàn Màn Hình)")
    add_image_figure(doc, "cau2_crud_video_list.png", "Giao diện Bảng quản trị danh sách Videos (/admin/videos) phân trang 6 video/trang")
    add_image_figure(doc, "cau2_crud_video_new.png", "Giao diện Form thêm mới Video vào hệ thống (/admin/videos?action=new)")
    add_image_figure(doc, "cau2_crud_video_edit.png", "Giao diện Form cập nhật thông tin Video (/admin/videos?action=edit&id=VID01)")

    # =========================================================================
    # CÂU 3 (1.5đ): CHI TIẾT VIDEO
    # =========================================================================
    add_heading_1(doc, "CÂU 3 (1.5 ĐIỂM): XÂY DỰNG TRANG CHI TIẾT 01 VIDEO THEO MẪU")
    add_callout(doc, [
        "• Yêu cầu cấu trúc hiển thị theo đúng khuôn mẫu trong đề thi:",
        "    [poster] Tiêu đề:",
        "             Mã video:",
        "             Category name:",
        "             View:",
        "             Share(10)",
        "             Like(10)",
        "             description",
        "• Khi người dùng truy cập trang chi tiết, hệ thống tự động tăng biến đếm View trong CSDL.",
        "• Số lượng Share và Like được tính toán động từ 2 bảng liên kết Share và Favorite trong CSDL."
    ], title="Yêu cầu đề bài & Phân tích giải thuật:")

    add_heading_2(doc, "4.1. Data Access Layer & Business Layer (Favorite / Share Service)")
    add_code_block(doc, "IFavoriteService_24110251.java & IShareService_24110251.java", read_file("src/main/java/com/template/service/IFavoriteService_24110251.java"), max_lines=25)
    add_code_block(doc, "FavoriteDaoImpl_24110251.java (Đếm Like theo videoId)", read_file("src/main/java/com/template/dao/FavoriteDaoImpl_24110251.java"), max_lines=35)
    add_code_block(doc, "ShareDaoImpl_24110251.java (Đếm Share theo videoId)", read_file("src/main/java/com/template/dao/ShareDaoImpl_24110251.java"), max_lines=35)

    add_heading_2(doc, "4.2. Presentation Layer (VideoDetailController)")
    add_code_block(doc, "VideoDetailController_24110251.java (Tăng view, nạp share, like và forward chi tiết)", read_file("src/main/java/com/template/controller/VideoDetailController_24110251.java"), max_lines=45)

    add_heading_2(doc, "4.3. Views (detail.jsp)")
    add_code_block(doc, "view/web/detail.jsp (Giao diện chi tiết video theo mẫu chuẩn của đề thi)", read_file("src/main/webapp/view/web/detail.jsp"), max_lines=50)

    add_heading_2(doc, "4.4. Kết quả thực nghiệm Trang Chi Tiết Video (Hình ảnh Chụp Toàn Màn Hình)")
    add_image_figure(doc, "cau3_video_detail.png", "Giao diện Chi tiết 1 Video (/video/detail?id=VID01) hiển thị đầy đủ Poster, Tiêu đề, Mã video, Category name, View, Share, Like và Description")

    # =========================================================================
    # CÂU 4 & CÂU 5 (3.0đ): HOME USER PHÂN TRANG 3 VIDEO & ĐẾM SỐ LƯỢNG
    # =========================================================================
    add_heading_1(doc, "CÂU 4 (2.5 ĐIỂM) & CÂU 5 (0.5 ĐIỂM): TRANG CHỦ USER HIỂN THỊ VIDEO THEO TỪNG CATEGORY PHÂN TRANG 3 VIDEO/TRANG & ĐẾM SỐ LƯỢNG")
    add_callout(doc, [
        "• Câu 4 (2.5đ): Xây dựng trang Home của vai trò User hiển thị tất cả video theo từng danh mục (Category).",
        "  + Mỗi danh mục có phân trang độc lập đúng 3 video trên 01 trang: << 1 2 3 4 5 >>.",
        "  + Người dùng có thể chuyển trang ở danh mục này mà không làm ảnh hưởng đến trang hiện tại của danh mục khác.",
        "• Câu 5 (0.5đ): Đếm số lượng Video theo từng Category và hiển thị ngay trên tiêu đề danh mục: Category Name (20).",
        "• Hiển thị mỗi video theo card chuẩn: [poster], Tiêu đề, Mã video, Category name, View, Share(10), Like(10) và nút xem Chi tiết."
    ], title="Yêu cầu đề bài:")

    add_heading_2(doc, "5.1. Data Access Layer (Phân trang 3 video & Đếm video theo Category)")
    add_callout(doc, [
        "Sử dụng JPQL truy vấn danh sách video thuộc Category có phân trang:",
        "SELECT v FROM Video_24110251 v WHERE v.category.categoryId = :catId ORDER BY v.videoId ASC",
        "setFirstResult((page - 1) * 3).setMaxResults(3)",
        "Đếm tổng số video trong Category (Câu 5):",
        "SELECT COUNT(v) FROM Video_24110251 v WHERE v.category.categoryId = :catId"
    ], title="Giải thuật JPQL phân trang và đếm:")
    add_code_block(doc, "VideoDaoImpl_24110251.java (findByCategoryId & countByCategoryId)", read_file("src/main/java/com/template/dao/VideoDaoImpl_24110251.java"), max_lines=50)

    add_heading_2(doc, "5.2. Presentation Layer (HomeController)")
    add_code_block(doc, "HomeController_24110251.java (Xử lý nạp danh mục, phân trang 3 video/trang và map số lượng)", read_file("src/main/java/com/template/controller/HomeController_24110251.java"), max_lines=50)

    add_heading_2(doc, "5.3. Views (home.jsp)")
    add_code_block(doc, "view/web/home.jsp (Giao diện hiển thị danh mục, số lượng đếm câu 5 và phân trang câu 4)", read_file("src/main/webapp/view/web/home.jsp"), max_lines=50)

    add_heading_2(doc, "5.4. Kết quả thực nghiệm Trang Chủ User (Hình ảnh Chụp Toàn Màn Hình)")
    add_image_figure(doc, "cau4_5_user_home.png", "Giao diện Trang chủ Người dùng (/home) hiển thị video theo từng Category kèm số lượng đếm (Câu 5) và thanh phân trang 3 video/trang (Câu 4)")

    # =========================================================================
    # TỔNG KẾT
    # =========================================================================
    add_heading_1(doc, "TỔNG KẾT VÀ ĐÁNH GIÁ KẾT QUẢ ĐẠT ĐƯỢC")
    add_callout(doc, [
        "1. Kiến trúc hệ thống: Tuân thủ nghiêm ngặt mô hình 3 lớp (Presentation - Business - DAO), phân tách rõ ràng trách nhiệm giữa Servlet Controller, Service và DAO với JPA Hibernate.",
        "2. SiteMesh 3 Decorators: Đã thiết lập hoàn chỉnh Decorator cho User (web.jsp) và Admin (admin.jsp), hỗ trợ kế thừa layout, Header menu chuẩn đề, Footer chứa thông tin sinh viên Nguyễn Quốc Khánh - 24110251 - Đề số 03.",
        "3. Bảo mật & Xác thực: Đầy đủ chức năng Đăng ký kích hoạt OTP qua Email, Đăng nhập lưu Session, Đăng xuất dọn dẹp Session, phân quyền truy cập Admin chặt chẽ.",
        "4. Quản trị CRUD Videos: Thực hiện đầy đủ thêm, sửa, xóa, hiển thị danh sách có phân trang chuẩn 6 video/trang.",
        "5. Trang chi tiết Video: Hiển thị đầy đủ tất cả các trường dữ liệu theo mẫu, tính động số lượng Share và Like.",
        "6. Trang Home User: Hiển thị video gom nhóm theo danh mục, tính năng đếm số lượng video mỗi Category (Câu 5) và phân trang độc lập 3 video/trang (Câu 4) hoạt động trơn tru.",
        "Toàn bộ kết quả mã nguồn và ảnh chụp giao diện thực tế đã được tổng hợp chi tiết và đầy đủ trong báo cáo này."
    ], title="Kết luận đánh giá:", fill_hex="EAFAF1", border_color="196F3D")

    print(f"Saving final report to {TARGET_DOCX}...")
    doc.save(TARGET_DOCX)
    print("Report saved successfully!")

if __name__ == "__main__":
    build_report()
