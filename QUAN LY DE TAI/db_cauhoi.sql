***Dùng các hàm gộp 
-- Câu 1: Cho biết số lượng giáo viên của toàn trường
-- Câu 2: Cho biết số lượng giáo viên của bộ môn HTTT
-- Câu 3: Tính số lượng giáo viên có người quản lý về mặt chuyên môn
-- Câu 4: Tính số lượng giáo viên làm nhiệm vụ quản lý chuyên môn cho giáo viên khác mà
thuộc bộ môn HTTT.
-- Câu 5:  Tính lương trung bình của giáo viên bộ môn Hệ thống thông tin
***Dùng group by
-- Câu 6: Với mỗn bộ môn cho biết bộ môn (MAMB) và số lượng giáo viên của bộ môn đó.
-- Câu 7: Với mỗi giáo viên, cho biết MAGV và số lượng công việc mà giáo viên đó có tham
gia.
-- Câu 8: Với mỗi giáo viên, cho biết MAGV và số lượng đề tài mà giáo viên đó có tham gia.
-- Câu 9:  Với mỗi bộ môn, cho biết số đề tài mà giáo viên của bộ môn đó chủ trì
-- Câu 10: Với mỗn bộ môn cho biết tên bộ môn và số lượng giáo viên của bộ môn đó.
***Dùng GROUP BY + HAVING
-- Câu 11: Cho biết những bộ môn từ 2 giáo viên trở lên.
-- Câu 12: Cho tên những giáo viên và số lượng đề tài của những GV tham gia từ 3 đề tài trở
lên.
-- Câu 13: Cho biết số lượng đề tài được thực hiện trong từng năm.
************************************************A
Dùng truy vấn con + mệnh đề SELECT
-- Câu A1: Với mỗi bộ môn, cho biết tên bộ môn và số lượng giáo viên của bộ môn đó.
Dùng truy vấn con + mệnh đề FROM
-- Câu A2: Cho biết họ tên và lương của các giáo viên bộ môn HTTT
Dùng truy vấn con + mệnh đề WHERE
-- Câu A3: Cho biết những giáo viên có lương lớn hơn lương của giáo viên có MAGV=‘001’
-- Câu A4: Cho biết họ tên những giáo viên mà không có một người thân nào
-- Câu A5: Cho những giáo viên có tham gia đề tài
-- Câu A6: Cho những giáo viên có lương nhỏ nhất
-- Câu A7: Cho những giáo viên có lương cao hơn tất cả các giáo viên của bộ môn HTTT
-- Câu A8: Cho biết bộ môn (MABM) có đông giáo viên nhất
-- Câu A9: Cho biết họ tên những giáo viên mà không có một người thân nào. (Sử dụng ALL
thay vì NOT IN)
-- Câu A10: Cho biết họ tên những giáo viên có tham gia đề tài. (Sử dụng = ANY thay vì IN)
-- Câu A11: Cho biết các giáo viên có tham gia đề tài.
-- Câu A12: Cho biết các giáo viên không có người thân
-- Câu A14: Cho biết những giáo viên có lương lớn hơn lương trung bình của bộ môn mà giáo
viên đó làm việc.
-- Câu A15: Cho biết những giáo viên có lương lớn nhất
-- Câu A16: Cho biết những đề tài mà giáo viên ‘001’ không tham gia.
-- Câu A17: Cho biết họ tên những giáo viên có vai trò quản lý về mặt chuyên môn với các giáo
viên khác
-- Câu A18: Cho biết những giáo viên có lương lớn nhất.
-- Câu A19: Cho biết những bộ môn (MABM) có đông giáo viên nhấ
-- Câu A20: Cho biết những tên bộ môn, họ tên của trưởng bộ môn và số lượng giáo viên của
bộ môn có đông giáo viên nhất
-- Câu A21: Cho biết những giáo viên có lương lớn hơn mức lương trung bình của giáo viên bộ
môn Hệ thống thông tin mà không trực thuộc bộ môn hệ thống thông tin
-- Câu A22: Cho tên biết đề tài có đông giáo viên tham gia nhất
viên bộ môn Hệ thống thông tin mà không trực thuộc bộ môn hệ thống thông tin
************************************************B
-- Câu B2: Tìm các giáo viên không tham gia đề tài nào
-- Câu B3: Tìm các giáo viên vừa tham gia đề tài vừa là trưởng bộ môn.
-- Câu B4: Liệt kê những giáo viên có tham gia đề tài và những giáo viên là trưởng bộ môn.
-- Câu B5: Tìm các giáo viên (MAGV) mà tham gia tất cả các đề tài
-- Câu B6: Tìm các giáo viên (MAGV) mà tham gia tất cả các đề tài (Dùng NOT EXISTS)
-- Câu B7: Tìm các giáo viên (MAGV) mà tham gia tất cả các đề tài (Dùng NOT EXISTS)
-- Câu B9: Tìm tên các giáo viên ‘HTTT’ mà tham gia tất cả các đề tài thuộc chủ đề ‘QLGD


-- ADVANCED
-- Cho biết tên giáo viên và tên của giáo viên có nhiều người thân nhất
-- Cho biết tên của giáo viên lớn tuổi nhất của bộ môn hệ thống thông tin
-- Cho biết tên những đề tài mà giáo viên Nguyễn Hoài An chưa tham gia
-- Cho biết tên của giáo viên chủ nhiệm nhiều đề tài nhất.
-- Cho biết tên giáo viên và tên bộ môn của giáo viên tham gia nhiều đề tài nhất
-- Cho biết tên đề tài nào mà được tất cả giáo viên của bộ môn hóa hữu cơ tham gia
