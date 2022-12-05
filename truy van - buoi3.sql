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
delimiter //
drop procedure if exists `sp_insertgiaovien`;
CREATE PROCEDURE `sp_insertgiaovien`(
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
    set maxMAGV = cast((SELECT MAGV FROM giaovien order by MAGV desc limit 1) as decimal);
    set maxMAGV = maxMAGV + 1;
    if(maxMAGV<10) then
		set strMAGV = concat('00', maxMAGV);
	elseif
	(maxMAGV<100) then
		set strMAGV = concat('0', maxMAGV);
	elseif
	(maxMAGV<1000) then
		set strMAGV = maxMAGV;
	end if;
	if(exists (select * from bomon where bomon.MABM = pMABM)) then
		insert into giaovien(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM,MABM) values
		(strMAGV,pHoTen,pLuong,pPhai,pNgaySinh,pDiaChi,pGVQLCM,pMABM);
        select giaovien.maGV from giaovien where giaovien.HOTEN = pHOTEN;
        else
			set pMessage = "Ma bo mon khong ton tai";
	end if;
END //


--------------------------------------------------
delimiter //
drop procedure if exists `sp_insertgiaovien`;
CREATE PROCEDURE `sp_insertgiaovien`(
	in pHoTen varchar(40),
    in pLuong decimal,
    in pPhai varchar(3),
    in pNgaySinh date,
    in pDiaChi varchar(50),
    in pGVQLCM varchar(3),
    in pMABM varchar(4),
    inout pMaGV varchar(3),
    out pMessage varchar(200)
)
begin
	declare maxMAGV decimal;
    declare strMAGV varchar(3);
    set maxMAGV = cast((SELECT MAGV FROM giaovien order by MAGV desc limit 1) as decimal);
    set maxMAGV = maxMAGV + 1;
    if(maxMAGV<10) then
		set strMAGV = concat('00', maxMAGV);
	elseif
	(maxMAGV<100) then
		set strMAGV = concat('0', maxMAGV);
	elseif
	(maxMAGV<1000) then
		set strMAGV = maxMAGV;
	end if;
	if(exists (select * from bomon where bomon.MABM = pMABM)) then
		insert into giaovien(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM,MABM) values
		(strMAGV,pHoTen,pLuong,pPhai,pNgaySinh,pDiaChi,pGVQLCM,pMABM);
        select giaovien.maGV from giaovien where giaovien.HOTEN = pHOTEN;
        set pMaGV = strMAGV;
        else
			set pMessage = "Ma bo mon khong ton tai";
	end if;
    
    select * from giaovien where MAGV = pMaGV;
END //


-------------------------------------------
delimiter //
drop procedure if exists sp_xoamotkhoa;
CREATE PROCEDURE `sp_XoaMotKhoa`(
in pTenKhoa varchar(40),
out pMessage varchar(50)
)
BEGIN
	declare pMaKhoa varchar(10);
    set pMaKhoa = (select khoa.makhoa from khoa
	where khoa.tenkhoa = pTenKhoa);
if 
	exists (select khoa.makhoa from khoa
	where khoa.tenkhoa = pTenKhoa)
then 
	UPDATE bomon SET bomon.makhoa = NULL WHERE bomon.makhoa = pMaKhoa;
	DELETE FROM khoa WHERE khoa.makhoa = pMaKhoa;

else
set pMessage = 'ten khoa khong co trong danh sach';
end if;
END //
--------------------
delimiter //
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_themcongviec`(
in Ptencongviec varchar(50),
in Pmadetai varchar(3),
in Pmagiaovien varchar(3),
in Pngaybatdau date,
in Pngayketthuc date,
out Pmessage varchar(50)
)
BEGIN

-- nhập vào: tên công việc, mã đề tài, mã giáo viên
-- b1: nhập tên công việc
-- b2: nhập mã đề tài
-- b3: nhập mã giáo viên tham gia
-- check: 
-- + mã đề tài xem có trong danh sách hay không, nếu không có alert = 'mã đề tài không có trong danh sách';
-- + check SOTT tăng dần
-- + check mã giáo viên có trong danh sách hay không, nếu không có alert = 'mã giáo viên không có trong danh sách';

declare maxSOTT int;
set maxSOTT = (select max(congviec.sott) from congviec where madt = Pmadetai group by madt);
set maxSOTT = maxSOTT + 1;	

if
	not exists(select detai.madt from detai where detai.madt = Pmadetai) 
    then  set Pmessage = 'ma id detai khong ton tai';
elseif
	not exists(select giaovien.magv from giaovien where giaovien.magv = Pmagiaovien)
    then  set Pmessage = 'ma id giaovien khong ton tai';
elseif
	exists(select congviec.tencv from congviec
    where congviec.tencv = Ptencongviec and congviec.madt = Pmadetai)
    then set Pmessage = 'ten cong viec da ton tai trong he thong';
else
	if
		not exists(select congviec.madt from congviec where congviec.madt = Pmadetai)
		then
        insert into congviec(madt,sott,tencv,ngaybd,ngaykt)
		values(Pmadetai,1,Ptencongviec,Pngaybatdau,Pngayketthuc);
        
		insert into thamgiadt(magv,madt,stt)
		values(Pmagiaovien,Pmadetai,1);
    else
		insert into congviec(madt,sott,tencv,ngaybd,ngaykt)
		values(Pmadetai,maxSOTT,Ptencongviec,Pngaybatdau,Pngayketthuc);
		insert into thamgiadt(magv,madt,stt)
		values(Pmagiaovien,Pmadetai,maxSOTT);
     end if;

end if;
END //	
-------------------------------

--------------------
delimiter //
drop procedure if exists sp_themcongviecCach2;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_themcongviecCach2`(
in Ptencongviec varchar(50),
in Pmadetai varchar(3),
in Pmagiaovien varchar(3),
in Pngaybatdau date,
in Pngayketthuc date,
out Pmessage varchar(50)
)
BEGIN
declare maxSOTT int;
set maxSOTT = (select max(congviec.sott) from congviec where madt = Pmadetai group by madt);
-- Nếu so sánh với NULL thì không thể dung = null mà dùng IS NULL
if(maxSOTT is NULL) then
		set maxSOTT = 1;
    else 
		set maxSOTT = maxSOTT + 1;	
end if;


if
	not exists(select detai.madt from detai where detai.madt = Pmadetai) 
    then  set Pmessage = 'ma id detai khong ton tai';
elseif
	not exists(select giaovien.magv from giaovien where giaovien.magv = Pmagiaovien)
    then  set Pmessage = 'ma id giaovien khong ton tai';
elseif
	exists(select congviec.tencv from congviec
    where congviec.tencv = Ptencongviec and congviec.madt = Pmadetai)
    then set Pmessage = 'ten cong viec da ton tai trong he thong';
else
		insert into congviec(madt,sott,tencv,ngaybd,ngaykt)
		values(Pmadetai,maxSOTT,Ptencongviec,Pngaybatdau,Pngayketthuc);
		insert into thamgiadt(magv,madt,stt)
		values(Pmagiaovien,Pmadetai,maxSOTT);
        
        set Pmessage = 'Them cong viec thanh cong';
end if;
END //	

--------------------
delimiter //
drop procedure if exists sp_themcongviecNhieuGiaoVien;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_themcongviecNhieuGiaoVien`(
in pMaGV varchar(300)
)
BEGIN

    -- Kiểm tra dữ liệu nhập vào của bảng công việc
    -- Các bạn thêm vào bảng công việc ở đây
    set @lenghtCount = LENGTH(pMaGV) - LENGTH(replace(pMaGV, ',', '')) +1;
    set @item = 0;
	CREATE TEMPORARY TABLE if not exists tb_giaovien  (
		MaGV varchar(3)
    );
    while @item < @lenghtCount do
		set @valueMaGV = SUBSTR(pMaGV, 1 + 4*@item, 3);
        set @item = @item+1;
        -- Các bạn thêm vào bảng tham gia đề tài ở đây
		insert into `tb_giaovien`(MaGV) values (@valueMaGV);
        
	end while;
    select * from tb_giaovien;
    drop table tb_giaovien;
END //














