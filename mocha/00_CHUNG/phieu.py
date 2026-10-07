#!/usr/bin/env python3
"""Phiếu nhận việc dạng Excel — chỉ dùng thư viện có sẵn của Python, không cần cài gì.

Chạy từ thư mục phòng:
  python3 .luat-chung/phieu.py tao --ra bao-cao/2026-10-07_phieu-nhan-viec.xlsx [--goi "chị Quyên"] [--da-biet da-biet.json]
  python3 .luat-chung/phieu.py doc <file.xlsx>
  python3 .luat-chung/phieu.py ds [--goi "chị Quyên"]

tao: lấy câu hỏi chung + câu riêng của phòng (tên phòng đọc từ dòng đầu AGENTS.md) trong cau-hoi-nhan-viec.csv.
     --da-biet: JSON {"<mã câu>": "điều em đã biết [Nguồn: file]"} → điền sẵn cột "Em đã biết".
doc: in JSON các dòng của phiếu: ma, cau_hoi, da_biet, tra_loi, ghi_vao.
ds:  in danh sách câu hỏi ĐÚNG của phòng này (đã lọc câu riêng, đúng thứ tự) + tổng số câu — dùng để đếm N và để hỏi trực tiếp.
"""
import argparse, csv, json, os, re, sys, zipfile
from xml.etree import ElementTree as ET
from xml.sax.saxutils import escape

HERE = os.path.dirname(os.path.abspath(__file__))
NGAN_HANG = os.path.join(HERE, "cau-hoi-nhan-viec.csv")
COT = ["Mã", "Phần", "Câu hỏi", "Gợi ý", "Em đã biết (kiểm tra lại giúp em)", "Câu trả lời"]
RONG = [7, 14, 60, 38, 42, 60]
SHEET = "Phieu"


def ten_phong():
    try:
        dau = open("AGENTS.md", encoding="utf-8").readline()
    except OSError:
        sys.exit("Không thấy AGENTS.md — hãy chạy lệnh từ thư mục phòng.")
    m = re.match(r"#\s*Phòng\s+(.+?)\s+—", dau)
    return m.group(1).strip() if m else ""


RIENG = "cau-hoi-rieng.csv"  # câu riêng agent tự soạn cho phòng (nằm ở thư mục phòng); có file này thì thay câu riêng mẫu


def cau_hoi(phong, goi):
    ten = phong.lower()
    co_rieng = os.path.isfile(RIENG)
    nguon = []
    with open(NGAN_HANG, encoding="utf-8") as f:
        for r in csv.DictReader(f):
            if r["phong"] and (co_rieng or not any(a.strip().lower() in ten for a in r["phong"].split("|"))):
                continue
            nguon.append(r)
    if co_rieng:
        with open(RIENG, encoding="utf-8") as f:
            nguon += [{**r, "phong": ""} for r in csv.DictReader(f) if (r.get("ma") or "").strip()]
    rows = []
    for r in nguon:
        q = (r["cau_hoi"].replace("{phong}", phong or "mình")
             .replace("{GOI}", goi.upper()).replace("{Goi}", goi[:1].upper() + goi[1:]).replace("{goi}", goi))
        rows.append({**r, "goi_y": r.get("goi_y", ""), "ghi_vao": r.get("ghi_vao", ""), "cau_hoi": q})
    return rows


def ds(a):
    phong = ten_phong()
    qs = cau_hoi(phong, a.goi)
    for q in qs:
        print(f"{q['ma']}\t{q['phan']}\t{q['cau_hoi']}\t[gợi ý: {q['goi_y'] or '—'}]\t[ghi vào: {q['ghi_vao']}]")
    print(f"# Phòng {phong or '(không rõ)'}: {len(qs)} câu")


# ---------- ghi xlsx ----------
def _col(i):
    s = ""
    i += 1
    while i:
        i, r = divmod(i - 1, 26)
        s = chr(65 + r) + s
    return s


def _cell(ref, text, style):
    text = re.sub(r"[\x00-\x08\x0b\x0c\x0e-\x1f]", "", str(text or ""))
    return f'<c r="{ref}" t="inlineStr" s="{style}"><is><t xml:space="preserve">{escape(text)}</t></is></c>'


def _sheet(rows, widths, freeze=0, tab=False, merges=(), heights=None):
    cols = "".join(f'<col min="{i+1}" max="{i+1}" width="{w}" customWidth="1"/>' for i, w in enumerate(widths))
    sel = ' tabSelected="1"' if tab else ""
    pane = (f'<pane ySplit="{freeze}" topLeftCell="A{freeze+1}" activePane="bottomLeft" state="frozen"/>') if freeze else ""
    pane = f'<sheetViews><sheetView{sel} workbookViewId="0">{pane}</sheetView></sheetViews>'
    body = ""
    for ri, row in enumerate(rows, 1):
        ht = f' ht="{heights[ri]}" customHeight="1"' if heights and ri in heights else ""
        body += f'<row r="{ri}"{ht}>' + "".join(_cell(f"{_col(ci)}{ri}", v, s) for ci, (v, s) in enumerate(row)) + "</row>"
    return ('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
            '<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">'
            f"{pane}<cols>{cols}</cols><sheetData>{body}</sheetData>"
            + (f'<mergeCells count="{len(merges)}">' + "".join(f'<mergeCell ref="{m}"/>' for m in merges) + "</mergeCells>" if merges else "")
            + "</worksheet>")


STYLES = """<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">
<fonts count="2"><font><sz val="11"/><name val="Arial"/></font><font><b/><sz val="11"/><name val="Arial"/></font></fonts>
<fills count="4"><fill><patternFill patternType="none"/></fill><fill><patternFill patternType="gray125"/></fill>
<fill><patternFill patternType="solid"><fgColor rgb="FFD9E1F2"/></patternFill></fill>
<fill><patternFill patternType="solid"><fgColor rgb="FFFFF2CC"/></patternFill></fill></fills>
<borders count="2"><border><left/><right/><top/><bottom/><diagonal/></border><border><left style="thin"/><right style="thin"/><top style="thin"/><bottom style="thin"/><diagonal/></border></borders>
<cellStyleXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0"/></cellStyleXfs>
<cellXfs count="5">
<xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0"/>
<xf numFmtId="0" fontId="1" fillId="2" borderId="1" xfId="0" applyFont="1" applyFill="1" applyBorder="1" applyAlignment="1"><alignment wrapText="1" vertical="top"/></xf>
<xf numFmtId="0" fontId="0" fillId="0" borderId="1" xfId="0" applyBorder="1" applyAlignment="1"><alignment wrapText="1" vertical="top"/></xf>
<xf numFmtId="0" fontId="0" fillId="3" borderId="1" xfId="0" applyFill="1" applyBorder="1" applyAlignment="1"><alignment wrapText="1" vertical="top"/></xf>
<xf numFmtId="0" fontId="1" fillId="0" borderId="0" xfId="0" applyFont="1" applyAlignment="1"><alignment wrapText="1" vertical="top"/></xf>
</cellXfs><cellStyles count="1"><cellStyle name="Normal" xfId="0" builtinId="0"/></cellStyles></styleSheet>"""


def tao(a):
    phong = ten_phong()
    da_biet = json.load(open(a.da_biet, encoding="utf-8")) if a.da_biet else {}
    qs = cau_hoi(phong, a.goi)
    hd = [
        [(f"PHIẾU NHẬN VIỆC — agent phòng {phong}", 4)],
        [("Em là agent AI của phòng. Để làm đúng việc, em cần " + a.goi + " trả lời các câu ở trang \"Phieu\".", 0)],
        [("1. Ghi câu trả lời vào cột F (ô màu vàng). Viết thoải mái, gạch đầu dòng cũng được.", 0)],
        [("2. Cột E là những gì em đã biết từ hồ sơ phòng: đúng thì ghi \"đúng\", sai hoặc thiếu thì sửa ở cột F.", 0)],
        [("3. Câu nào chưa biết hoặc không liên quan: để trống hoặc ghi \"bỏ qua\". Em sẽ hỏi lại sau.", 0)],
        [("4. Không ghi mật khẩu, số tài khoản, bảng lương, CCCD vào phiếu.", 0)],
        [("5. Điền xong gửi lại file này cho em trong cùng nhóm chat. Không tiện điền thì nhắn \"hỏi trực tiếp\", em hỏi từng câu.", 0)],
        [("6. Excel không đính kèm được file khác: các file mẫu, quy trình, bảng giá… (câu D16) cứ gửi tiếp ngay sau phiếu, em tự lưu và ghi nhận.", 0)],
    ]
    rows = [[(f"PHIẾU NHẬN VIỆC — agent phòng {phong}", 4)],
            [(f"Ghi câu trả lời vào cột F (ô vàng). Cột E là điều em đã biết: đúng thì ghi \"đúng\", sai thì sửa ở cột F. "
              "Chưa biết thì để trống. Không ghi mật khẩu, số tài khoản, lương. Xong gửi lại file cho em, "
              "rồi gửi tiếp luôn các file mẫu/tài liệu (Excel không đính kèm được file khác) — em tự lưu. "
              "Hướng dẫn đầy đủ: trang \"Huong dan\".", 0)],
            [(c, 1) for c in COT[:5]] + [(f"Câu trả lời của {a.goi}", 1)]]
    for q in qs:
        rows.append([(q["ma"], 2), (q["phan"], 2), (q["cau_hoi"], 2), (q["goi_y"], 2),
                     (da_biet.get(q["ma"], ""), 2), ("", 3)])
    os.makedirs(os.path.dirname(os.path.abspath(a.ra)), exist_ok=True)
    W = "http://schemas.openxmlformats.org/spreadsheetml/2006/main"
    R = "http://schemas.openxmlformats.org/officeDocument/2006/relationships"
    with zipfile.ZipFile(a.ra, "w", zipfile.ZIP_DEFLATED) as z:
        z.writestr("[Content_Types].xml",
                   '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                   '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">'
                   '<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>'
                   '<Default Extension="xml" ContentType="application/xml"/>'
                   '<Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>'
                   '<Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>'
                   '<Override PartName="/xl/worksheets/sheet2.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>'
                   '<Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>'
                   '</Types>')
        z.writestr("_rels/.rels",
                   '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                   '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'
                   '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/>'
                   '</Relationships>')
        z.writestr("xl/workbook.xml",
                   f'<?xml version="1.0" encoding="UTF-8" standalone="yes"?><workbook xmlns="{W}" xmlns:r="{R}"><sheets>'
                   f'<sheet name="{SHEET}" sheetId="1" r:id="rId1"/>'
                   '<sheet name="Huong dan" sheetId="2" r:id="rId2"/></sheets></workbook>')
        z.writestr("xl/_rels/workbook.xml.rels",
                   '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                   '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'
                   '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/>'
                   '<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet2.xml"/>'
                   '<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>'
                   '</Relationships>')
        z.writestr("xl/styles.xml", STYLES)
        z.writestr("xl/worksheets/sheet1.xml", _sheet(rows, RONG, freeze=3, tab=True, merges=("A1:F1", "A2:F2"), heights={1: 22, 2: 48}))
        z.writestr("xl/worksheets/sheet2.xml", _sheet(hd, [110]))
    print(f"Đã tạo {a.ra}: phòng {phong or '(không rõ)'} · {len(qs)} câu · điền sẵn {sum(1 for q in qs if da_biet.get(q['ma']))} câu")


# ---------- đọc xlsx (Excel, Google Sheets, Numbers xuất ra) ----------
NS = {"m": "http://schemas.openxmlformats.org/spreadsheetml/2006/main"}
RID = "{http://schemas.openxmlformats.org/officeDocument/2006/relationships}id"


def _text(el):
    return "".join(t.text or "" for t in el.iter("{%s}t" % NS["m"]))


def doc(a):
    z = zipfile.ZipFile(a.file)
    ss = []
    if "xl/sharedStrings.xml" in z.namelist():
        ss = [_text(si) for si in ET.fromstring(z.read("xl/sharedStrings.xml")).findall("m:si", NS)]
    wb = ET.fromstring(z.read("xl/workbook.xml"))
    rels = {r.get("Id"): r.get("Target") for r in ET.fromstring(z.read("xl/_rels/workbook.xml.rels"))}
    for sh in wb.find("m:sheets", NS):
        target = rels[sh.get(RID)].lstrip("/")
        path = target if target.startswith("xl/") else "xl/" + target
        bang = []
        for row in ET.fromstring(z.read(path)).iter("{%s}row" % NS["m"]):
            vals = {}
            for c in row.findall("m:c", NS):
                col = re.match(r"[A-Z]+", c.get("r")).group()
                t, v = c.get("t"), c.find("m:v", NS)
                if t == "s" and v is not None:
                    val = ss[int(v.text)]
                elif t == "inlineStr":
                    val = _text(c)
                else:
                    val = v.text if v is not None else ""
                vals[col] = (val or "").strip()
            bang.append(vals)
        h = next((i for i, r in enumerate(bang) if r.get("A") == "Mã"), None)
        if h is None:
            continue
        dau = {v: k for k, v in bang[h].items()}
        c_tl = next((k for v, k in dau.items() if v.startswith("Câu trả lời")), "F")
        c_db = next((k for v, k in dau.items() if v.startswith("Em đã biết")), "E")
        c_q = dau.get("Câu hỏi", "C")
        goc = {}
        try:
            with open(NGAN_HANG, encoding="utf-8") as f:
                goc = {r["ma"]: r["ghi_vao"] for r in csv.DictReader(f)}
        except OSError:
            pass
        out = [{"ma": r.get("A", ""), "cau_hoi": r.get(c_q, ""), "da_biet": r.get(c_db, ""),
                "tra_loi": r.get(c_tl, ""), "ghi_vao": goc.get(r.get("A", ""), "")}
               for r in bang[h+1:] if r.get("A")]
        json.dump(out, sys.stdout, ensure_ascii=False, indent=1)
        print(f"\n# {sum(1 for r in out if r['tra_loi'])}/{len(out)} câu có trả lời", file=sys.stderr)
        return
    sys.exit("Không tìm thấy trang có cột 'Mã' — có thể không phải phiếu nhận việc.")


if __name__ == "__main__":
    p = argparse.ArgumentParser()
    sp = p.add_subparsers(dest="lenh", required=True)
    t = sp.add_parser("tao"); t.add_argument("--ra", required=True); t.add_argument("--goi", default="anh/chị"); t.add_argument("--da-biet")
    d = sp.add_parser("doc"); d.add_argument("file")
    l = sp.add_parser("ds"); l.add_argument("--goi", default="anh/chị")
    a = p.parse_args()
    {"tao": tao, "doc": doc, "ds": ds}[a.lenh](a)
