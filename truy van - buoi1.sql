 -- Cho biết những bộ môn từ 2 giáo viên trở lên.
 select giaovien.MABM, bomon.TENBM, count(giaovien.MABM) as soluong
 from giaovien join bomon on giaovien.MABM = bomon.MABM
 group by giaovien.MABM 
 having soluong >= 2;
 
 -- Cho tên những giáo viên và số lượng đề tài của những GV tham gia từ 3 đề tài trở lên
 SELECT GV.HOTEN, COUNT(distinct tgdt.madt) AS 'so luong de tai'
 FROM GIAOVIEN GV JOIN thamgiadt TGDT ON GV.MAGV = TGDT.MAGV 
 GROUP BY tgdt.magv
 having COUNT(distinct TGDT.madt) >= 2;
 
 -- Cho biết số lượng đề tài được thực hiện trong từng năm
 SELECT YEAR(NGAYKT) as nam, COUNT(YEAR(NGAYKT)) as soluong
 FROM DETAI
 GROUP BY YEAR(NGAYKT)
 order by YEAR(NGAYKT);
 
 -- Với mỗi bộ môn, cho biết tên bộ môn và số lượng giáo viên của bộ môn đó
 SELECT bomon.TENBM, 
	(	
		SELECT count(giaovien.MABM)
        FROM giaovien
        where bomon.MABM = giaovien.MABM
	) as soluong
 FROM bomon ;
 
 -- Cho biết những giáo viên có lương lớn hơn lương của giáo viên có MAGV=‘001’
 SELECT *
 FROM GIAOVIEN
 WHERE giaovien.LUONG >	( SELECT giaovien.LUONG FROM giaovien where giaovien.MAGV = '001');
 
 -- Cho biết họ tên những giáo viên mà không có một người thân nào
 SELECT *
 FROM giaovien
 where giaovien.MAGV NOT IN ( SELECT distinct nguoithan.MAGV FROM nguoithan);

 SELECT *
 FROM giaovien
 where( SELECT COUNT(*) FROM NGUOITHAN WHERE NGUOITHAN.MAGV = giaovien.MAGV) = 0;
 
 -- Cho những giáo viên có tham gia đề tài
 
 -- Cho những giáo viên có lương nhỏ nhất
 SELECT *
 FROM GIAOVIEN
 where GIAOVIEN.LUONG <= ALL (SELECT distinct gv1.LUONG from giaovien gv1);
 
  SELECT *
 FROM GIAOVIEN
 where GIAOVIEN.LUONG = (SELECT min(LUONG) FROM quanlydetai.giaovien);
 
 -- Cho biết bộ môn (MABM) có đông giáo viên nhất
 SELECT *
 FROM GIAOVIEN
GROUP BY GIAOVIEN.MABM
HAVING COUNT(GIAOVIEN.MABM) >= ALL (SELECT count(GIAOVIEN.MABM) FROM GIAOVIEN group by GIAOVIEN.MABM);
 
 