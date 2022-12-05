-- Cho biết những giáo viên có lương lớn hơn mức lương trung bình của giáo viên bộ môn
SELECT gv1.HOTEN,gv1.LUONG, ( SELECT AVG(giaovien.LUONG) FROM giaovien WHERE giaovien.MABM = gv1.MABM) as luongtb
FROM giaovien gv1
where gv1.LUONG > ( SELECT AVG(giaovien.LUONG) FROM giaovien WHERE giaovien.MABM = gv1.MABM);

SELECT AVG(giaovien.LUONG) FROM giaovien WHERE giaovien.MABM = 'MMT';

-- Cach 2:
select giaovien.hoten, giaovien.luong, tb1.LUONGTB 
from giaovien join (
					select giaovien.mabm, avg(giaovien.luong) as luongtb from giaovien group by giaovien.mabm
					) as tb1	on giaovien.MABM = tb1.MABM 
where giaovien.LUONG > tb1.LUONGtb;

-- Tìm các giáo viên vừa tham gia đề tài vừa là trưởng bộ môn.
select distinct gv.MAGV, gv.HOTEN, bm.TENBM
from bomon bm join thamgiadt tg on bm.truongbm = tg.magv
	join giaovien gv on tg.MAGV  = gv.MAGV;
    
-- Cho biết tên những đề tài mà giáo viên Nguyễn Hoài An chưa tham gia
select DISTINCT dt.tendt
from detai dt
where dt.madt not in (
select DISTINCT tg.madt
from giaovien gv join thamgiadt tg on gv.magv = tg.MAGV
where gv.hoten like 'Cuong'
);

-- Cho biết tên giáo viên và tên bộ môn của SELECT thamgiadt.MAGV, giaovien.HOTEN, bomon.TENBM
SELECT thamgiadt.MAGV, giaovien.HOTEN, bomon.TENBM
FROM thamgiadt join giaovien on giaovien.MAGV = thamgiadt.MAGV join bomon on bomon.MABM = giaovien.MABM
WHERE thamgiadt.MAGV
GROUP BY thamgiadt.MAGV 
HAVING count(distinct thamgiadt.MADT) >= ALL (
		SELECT count(distinct thamgiadt.MADT) as sodetai
		FROM thamgiadt
		WHERE thamgiadt.MAGV
		GROUP BY thamgiadt.MAGV
);

SELECT thamgiadt.MAGV, giaovien.HOTEN, bomon.TENBM
FROM thamgiadt join giaovien on giaovien.MAGV = thamgiadt.MAGV join bomon on bomon.MABM = giaovien.MABM
WHERE thamgiadt.MAGV
GROUP BY thamgiadt.MAGV 
HAVING count(distinct thamgiadt.MADT) = (
	select max(temp.sodetai) as max from (SELECT count(distinct thamgiadt.MADT) as sodetai
	FROM thamgiadt
	WHERE thamgiadt.MAGV
	GROUP BY thamgiadt.MAGV) as temp
);

-----------------------------------
delimiter //
create procedure sp_InsertGiaoVien(
	in pHoTen varchar(40),
    in pLuong decimal,
    in pPhai varchar(3),
    in pNgaySinh date,
    in pDiaChi varchar(50),
    in pGVQLCM varchar(3),
    in pMABM varchar(4),
    out pMessage varchar(200)
)
begin
	declare maxMAGV decimal;
    declare strMAGV varchar(3);
    set maxMAGV = cast((SELECT MAGV FROM quanlydetai.giaovien order by MAGV desc limit 1) as decimal);
    set maxMAGV = maxMAGV + 1;
    if(maxMAGV<10) then
		set strMAGV = concat('00', maxMAGV);
	end if;
	if(maxMAGV<100) then
		set strMAGV = concat('0', maxMAGV);
	end if;
	if(maxMAGV<1000) then
		set strMAGV = maxMAGV;
	end if;
	if(exists (select * from bomon where bomon.MABM = pMABM)) then
		insert into giaovien(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM,MABM) values
		(strMAGV,pHoTen,pLuong,pPhai,pNgaySinh,pDiaChi,pGVQLCM,pMABM);
        
        else
			set pMessage = "Ma bo mon khong ton tai";
	end if;
end;//

--------------
CREATE PROCEDURE `sp_LayDeTaiKoThamGia`(
	IN sName varchar(200),
    OUT sMessage varchar(200)
)
BEGIN
	if(not exists (select giaovien.MAGV from giaovien where giaovien.HOTEN = sName)) then
		set sMessage = 'Giao vien khong ton tai';
        
        else
			select DISTINCT dt.tendt
			from detai dt
			where dt.madt not in (
			select DISTINCT tg.madt
			from giaovien gv join thamgiadt tg on gv.magv = tg.MAGV
			where gv.hoten like sName
			);
    end if;
	
END //

-------------------------------------------------

















