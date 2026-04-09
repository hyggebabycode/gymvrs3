import zipfile
import xml.etree.ElementTree as ET

def read_docx(fp):
    try:
        with zipfile.ZipFile(fp, 'r') as z:
            t = ET.fromstring(z.read('word/document.xml'))
            return '\n'.join(''.join(node.text for node in p.iter() if node.tag.endswith('}t') and node.text) for p in t.iter() if p.tag.endswith('}p'))
    except Exception as e:
        return str(e)

print('--- Nhom 8 ---')
print(read_docx(r'c:\Users\toanh\OneDrive\Dokumen\tailieuhoctap\3_2\laptrinhweb\webgymvs3\docs\Báo cáo CNPM - Nhóm 8.docx')[:2000])
print('\n--- Nhom 9 ---')
print(read_docx(r'c:\Users\toanh\OneDrive\Dokumen\tailieuhoctap\3_2\laptrinhweb\webgymvs3\docs\BaoCaoCNPM_Nhom9 (1).docx')[:2000])
