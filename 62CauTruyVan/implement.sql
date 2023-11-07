#1
SELECT MaSV, HoSV, TenSV, HocBong
FROM DMSV
ORDER BY MaSV;

#2
SELECT MaSV, CONCAT(HoSV, ' ', TenSV) AS HoTenSV, Phai, NgaySinh
FROM DMSV
ORDER BY Phai;

#3
SELECT CONCAT(HoSV, ' ', TenSV) AS HoTenSV, NgaySinh, HocBong
FROM DMSV
ORDER BY NgaySinh, HocBong DESC;

#4
SELECT MaMH, TenMH, SoTiet
FROM DMMH
WHERE TenMH LIKE 'T%';


#5
select CONCAT(HoSV, ' ', TenSV) AS HoTenSV, NgaySinh, Phai
from dmsv
where TenSV like '%i';

#6
# SUBSTRING(source_string, start_position, length)
SELECT MaKhoa, TenKhoa
FROM DMKhoa
WHERE SUBSTRING(TenKhoa, 2, 1) = 'N';

#7
SELECT MaSV, CONCAT(HoSV, ' ', TenSV) AS HoTenSV
FROM DMSV
WHERE HoSV LIKE '%Thị%';

#8
select MaSV, CONCAT(HoSV, ' ', TenSV) AS HoTenSV, MaKhoa, HocBong
from dmsv
where HocBong > 100000
order by MaKhoa desc;

#9
select CONCAT(HoSV, ' ', TenSV) AS HoTenSV, MaKhoa, NoiSinh
from dmsv
where HocBong >= 150000
  and NoiSinh like '%Hà Nội%';

#10
SELECT DMSV.MaSV, DMSV.MaKhoa, DMSV.Phai
FROM DMSV
WHERE DMSV.MaKhoa IN ('AV', 'VL');

#11
SELECT MaSV, NgaySinh, NoiSinh, HocBong
FROM DMSV
WHERE NgaySinh BETWEEN '1991-01-01' AND '1992-06-05';

#12
SELECT MaSV, NgaySinh, Phai, MaKhoa
FROM DMSV
WHERE HocBong >= 80000
  AND HocBong <= 150000;

#13
select *
from dmmh
where SoTiet > 30
  and SoTiet <= 45;

#14
SELECT DMSV.MaSV, CONCAT(DMSV.HoSV, ' ', DMSV.TenSV) AS HoTenSV, DMKhoa.TenKhoa, DMSV.Phai
FROM DMSV
         JOIN DMKhoa ON DMSV.MaKhoa = DMKhoa.MaKhoa
WHERE DMSV.Phai = 'Nam'
  AND DMKhoa.TenKhoa IN ('Anh Văn', 'Tin Học');

#15
select *
from dmsv
where Phai like 'Nữ'
  and TenSV like '%n%';

#16
SELECT HoSV, TenSV, NoiSinh, NgaySinh
from dmsv
where NoiSinh like 'Hà Nội'
  and month(NgaySinh) = 12;

#17
SELECT CONCAT(HoSV, ' ', TenSV)                 AS HoTenSV,
       TIMESTAMPDIFF(YEAR, NgaySinh, curdate()) AS Tuoi,
       HocBong
FROM DMSV
WHERE TIMESTAMPDIFF(YEAR, NgaySinh, curdate()) >= 20;

#18
SELECT CONCAT(HoSV, ' ', TenSV)                 AS HoTenSV,
       TIMESTAMPDIFF(YEAR, NgaySinh, CURDATE()) AS Tuoi,
       TenKhoa
FROM DMSV
         INNER JOIN DMKhoa ON DMKhoa.MaKhoa = DMSV.MaKhoa
WHERE TIMESTAMPDIFF(YEAR, NgaySinh, CURDATE()) BETWEEN 20 and 25;

#19
select CONCAT(HoSV, ' ', TenSV) AS HoTenSV,
       Phai,
       NgaySinh
from dmsv
where (month(NgaySinh) between 3 and 5)
  and year(NgaySinh) = 1990;

#20
# SELECT MaSV, Phai, MaKhoa,
#        CASE
#            WHEN HocBong > 500000 THEN 'Học bổng cao'
#            ELSE 'Mức trung bình'
#        END AS MucHocBong
# FROM DMSV;
select MaSV, Phai, MaKhoa, IF(HocBong > 500000, 'Học bổng cao', 'Mức trung bình') as MucHongBong
from dmsv;

#21
select count(*) as TongSoSinhVien
from dmsv;

#22
SELECT COUNT(*)                                          AS TongSinhVien,
       COUNT(CASE WHEN Phai = 'Nữ' THEN 1 ELSE NULL END) AS TongSinhVienNu
FROM DMSV;

#23
SELECT MaKhoa, COUNT(*) AS TongSoSinhVien
FROM DMSV
GROUP BY MaKhoa;

#24
SELECT DMMH.MaMH, DMMH.TenMH, COUNT(KetQua.MaSV) AS SoLuongSinhVien
FROM DMMH
         LEFT JOIN KetQua ON DMMH.MaMH = KetQua.MaMH
GROUP BY DMMH.MaMH, DMMH.TenMH;


#25
SELECT MaSV, COUNT(DISTINCT MaMH) AS SoLuongMonHoc
FROM KetQua
GROUP BY MaSV;

#26
SELECT MaKhoa, SUM(HocBong) AS TongHocBong
FROM DMSV
GROUP BY MaKhoa;

#27
SELECT MaKhoa, MAX(HocBong) AS HocBongCaoNhat
FROM DMSV
GROUP BY MaKhoa;

#28
SELECT MaKhoa,
       COUNT(CASE WHEN Phai = 'Nam' THEN 1 ELSE NULL END) AS TongSinhVienNam,
       COUNT(CASE WHEN Phai = 'Nữ' THEN 1 ELSE NULL END)  AS TongSinhVienNu
FROM DMSV
GROUP BY MaKhoa;
SELECT MaKhoa, sum(Phai like 'nam') as Nam, sum(phai like 'nữ') as Nữ
from dmsv
group by MaKhoa;

#29
SELECT TIMESTAMPDIFF(YEAR, NgaySinh, CURDATE()) AS Tuoi,
       COUNT(*)                                 AS SoLuongSinhVien
FROM DMSV
GROUP BY Tuoi
ORDER BY Tuoi;

#30
SELECT YEAR(NgaySinh) AS NamSinh, COUNT(*) AS SoLuongSinhVien
FROM DMSV
GROUP BY NamSinh
HAVING COUNT(*) >= 2;

#31
SELECT NoiSinh, COUNT(*) AS SoLuongSinhVien
FROM DMSV
GROUP BY NoiSinh
HAVING COUNT(*) >= 2;

#32
SELECT MaMH, COUNT(DISTINCT MaSV) AS SoSinhVien
FROM KetQua
GROUP BY MaMH
HAVING COUNT(DISTINCT MaSV) > 3;

#33
SELECT MaSV, COUNT(DISTINCT LanThi) AS SoLanThiLai
FROM KetQua
GROUP BY MaSV
HAVING COUNT(DISTINCT LanThi) >= 2;

#34
SELECT DMSV.MaSV, CONCAT(HoSV, ' ', TenSV) as HoTenSV, DMSV.Phai, AVG(KetQua.Diem) AS DiemTrungBinhLan1
FROM DMSV
         INNER JOIN KetQua ON DMSV.MaSV = KetQua.MaSV
WHERE DMSV.Phai = 'Nam'
  AND KetQua.LanThi = 1
GROUP BY DMSV.MaSV, DMSV.HoSV, DMSV.TenSV, DMSV.Phai
HAVING DiemTrungBinhLan1 > 7.0;

#35
SELECT DMSV.MaSV, DMSV.HoSV, DMSV.TenSV
FROM DMSV
         INNER JOIN KetQua ON DMSV.MaSV = KetQua.MaSV
WHERE KetQua.LanThi = 1
GROUP BY DMSV.MaSV, DMSV.HoSV, DMSV.TenSV
HAVING SUM(CASE WHEN Diem < 5.0 THEN 1 ELSE 0 END) >= 2;

#36
SELECT DMKhoa.MaKhoa, DMKhoa.TenKhoa, COUNT(DISTINCT DMSV.MaSV) as SoSinhVien
FROM DMKhoa
         INNER JOIN DMSV ON DMKhoa.MaKhoa = DMSV.MaKhoa
WHERE DMSV.Phai like 'Nữ'
GROUP BY DMKhoa.MaKhoa, DMKhoa.TenKhoa
HAVING COUNT(DISTINCT DMSV.MaSV) >= 2;

#37
SELECT DMSV.MaKhoa, DMKhoa.TenKhoa, COUNT(DISTINCT DMSV.MaSV) as SoLuongSV
FROM DMSV
         INNER JOIN DMKhoa ON DMSV.MaKhoa = DMKhoa.MaKhoa
WHERE DMSV.HocBong BETWEEN 100000 AND 200000
GROUP BY DMSV.MaKhoa, DMKhoa.TenKhoa
HAVING COUNT(DISTINCT DMSV.MaSV) >= 2;

#38
SELECT MaMH,
       SUM(CASE WHEN Diem >= 5.0 THEN 1 ELSE 0 END) AS SoLuongSinhVienDau,
       SUM(CASE WHEN Diem < 5.0 THEN 1 ELSE 0 END)  AS SoLuongSinhVienRot
FROM KetQua
WHERE LanThi = 1
GROUP BY MaMH;

#39
SELECT MaSV, HoSV, TenSV, HocBong
FROM DMSV
ORDER BY HocBong DESC
LIMIT 1;

#40
SELECT DMSV.MaSV, DMSV.HoSV, DMSV.TenSV, KetQua.Diem
FROM DMSV
         INNER JOIN KetQua ON DMSV.MaSV = KetQua.MaSV
         INNER JOIN DMMH ON KetQua.MaMH = DMMH.MaMH
WHERE DMMH.TenMH like 'Cơ Sở Dữ Liệu'
  AND KetQua.LanThi = 1
ORDER BY KetQua.Diem DESC
LIMIT 1;

#41
SELECT sv.MaSV,
       sv.TenSV,
       (year(now()) - year(sv.NgaySinh)) as tuoi
FROM dmsv sv
WHERE (year(now()) - year(sv.NgaySinh)) = (SELECT max((year(now()) - year(sv.NgaySinh))) as max FROM dmsv sv);

#42
SELECT sv.MaKhoa,
       count(sv.MaKhoa) soluong_Sv
FROM dmkhoa k
         LEFT JOIN dmsv sv ON sv.MaKhoa = k.MaKhoa
GROUP BY k.MaKhoa;

#43
SELECT sv.MaKhoa,
       count(sv.Phai) solg
FROM dmkhoa k
         LEFT JOIN dmsv sv ON sv.MaKhoa = k.MaKhoa
WHERE sv.Phai LIKE ('Nữ')
GROUP BY k.MaKhoa
HAVING solg = 2;

#44
SELECT mh.TenMH
FROM ketqua kq
         INNER JOIN dmmh mh ON mh.MaMH = kq.MaMH
WHERE kq.LanThi = 1
  AND kq.Diem < 5
GROUP BY (mh.TenMH)
ORDER BY count(mh.TenMH) DESC
LIMIT 1;

#45
SELECT sv.TenSV,
       r.kq
FROM dmsv sv
         INNER JOIN dmkhoa k ON k.MaKhoa = sv.MaKhoa
         INNER JOIN (SELECT kq.MaSV MaSV,
                            kq.MaMH,
                            mh.TenMH,
                            kq.Diem Kq
                     FROM ketqua kq
                              INNER JOIN dmmh mh ON mh.MaMH = kq.MaMH
                     WHERE mh.TenMH LIKE ('Văn Phạm')) AS r ON r.MaSV = sv.MaSV
WHERE k.TenKhoa LIKE ('Anh Văn');

#46
SELECT *
FROM dmsv sv2
WHERE sv2.NoiSinh IN (SELECT sv.NoiSinh FROM dmsv sv WHERE sv.TenSV LIKE ('Hải'));

#47
SELECT *
FROM dmsv sv1
         INNER JOIN dmkhoa k ON k.MaKhoa = sv1.MaKhoa
WHERE k.TenKhoa NOT LIKE ('Anh Văn')
  AND sv1.HocBong > ALL (SELECT sv.HocBong
                         FROM dmsv sv
                                  INNER JOIN dmkhoa k ON k.MaKhoa = sv.MaKhoa
                         WHERE k.TenKhoa LIKE ('Anh Văn'));


#48
SELECT *
FROM dmsv sv1
         INNER JOIN dmkhoa k ON k.MaKhoa = sv1.MaKhoa
WHERE k.TenKhoa NOT LIKE ('Anh Văn')
  AND sv1.HocBong > ANY (SELECT sv.HocBong
                         FROM dmsv sv
                                  INNER JOIN dmkhoa k ON k.MaKhoa = sv.MaKhoa
                         WHERE k.TenKhoa LIKE ('Anh Văn'));

#49
SELECT kq.MaSV,
       kq.Diem
FROM ketqua kq
         INNER JOIN dmmh mh ON mh.MaMH = kq.MaMH
WHERE kq.LanThi = 2
  AND mh.TenMH LIKE ('Cơ Sở Dữ Liệu')
HAVING kq.Diem >= ALL (SELECT kq.Diem
                       FROM ketqua kq
                                INNER JOIN dmmh mh ON mh.MaMH = kq.MaMH
                       WHERE kq.LanThi = 1
                         AND mh.TenMH LIKE ('Cơ Sở Dữ Liệu'));

#50
SELECT sv.TenSV,
       mh.TenMH,
       kq.Diem
FROM ketqua kq
         INNER JOIN dmsv sv ON sv.MaSV = kq.MaSV
         INNER JOIN dmmh mh ON mh.MaMH = kq.MaMH
WHERE kq.Diem >= ALL (SELECT max(kq.Diem)
                      FROM ketqua kq
                               INNER JOIN dmmh mh ON mh.MaMH = kq.MaMH
                      GROUP BY mh.TenMH);

#51
SELECT k.MaKhoa,
       k.TenKhoa,
       count(sv.MaKhoa) solg
FROM dmkhoa k
         LEFT JOIN dmsv sv ON sv.MaKhoa = k.MaKhoa
GROUP BY k.MaKhoa
HAVING solg = 0;

#52
SELECT *
FROM dmsv
WHERE MaSV NOT IN (SELECT kq.MaSV
                   FROM ketqua kq
                            INNER JOIN dmmh mh ON mh.MaMH = kq.MaMH
                   WHERE mh.TenMH LIKE ('Cơ Sở Dữ Liệu')
                   GROUP BY kq.MaSV);

#53
SELECT *
FROM (SELECT MaSV, MaMH
      FROM ketqua
      WHERE LanThi = 2) AS A
         LEFT JOIN
     (SELECT MaSV, MaMH
      FROM ketqua
      WHERE LanThi = 1
      ORDER BY MaSV) AS B ON B.MaSV = A.MaSV AND B.MaMH = B.MaMH
HAVING B.MaSV IS NULL
ORDER BY A.MaSV;

#54
SELECT mh.TenMH
FROM dmmh mh
         LEFT JOIN
     (SELECT DISTINCT kq.MaMH MaMH, kq.MaSV MSV
      FROM ketqua kq
      WHERE kq.MaSV IN (SELECT sv.MaSV
                        FROM dmsv sv
                                 INNER JOIN dmkhoa k ON k.MaKhoa = sv.MaKhoa
                        WHERE k.TenKhoa LIKE ('Anh Văn'))) AS B ON B.MaMH = mh.MaMH
WHERE B.MSV IS NULL;

#55
SELECT sv.MaSV, sv.TenSV
FROM dmsv sv
         INNER JOIN dmkhoa k ON k.MaKhoa = sv.MaKhoa
WHERE k.TenKhoa LIKE ('Anh Văn')
  AND sv.MaSV NOT IN (SELECT kq.MaSV
                      FROM ketqua kq
                               INNER JOIN dmmh mh ON mh.MaMH = kq.MaMH
                      WHERE mh.TenMH LIKE ('Văn Phạm'));

#56
SELECT sv.MaSV, concat(sv.HoSV, '', sv.TenSV) HoTen, kq.MaMH, kq.Diem, kq.LanThi
FROM dmsv sv
         LEFT JOIN ketqua kq ON kq.MaSV = sv.MaSV
WHERE kq.Diem > 5;

#57
SELECT *
FROM dmsv sv
         INNER JOIN dmkhoa k ON k.MaKhoa = sv.MaKhoa
WHERE k.TenKhoa LIKE ('Anh Văn')
  AND sv.HocBong > 0;

#58
SELECT k.TenKhoa,
       count(sv.HocBong) so_lg
FROM dmsv sv
         INNER JOIN dmkhoa k ON k.MaKhoa = sv.MaKhoa
WHERE sv.HocBong > 0
GROUP BY k.TenKhoa
HAVING count(sv.HocBong)
           IN (SELECT max(A.so_lg) AS `Max`
               FROM (SELECT k.TenKhoa, count(sv.HocBong) so_lg
                     FROM dmsv sv
                              INNER JOIN dmkhoa k ON k.MaKhoa = sv.MaKhoa
                     WHERE sv.HocBong > 0
                     GROUP BY k.TenKhoa) AS A);

#59
SELECT DISTINCT kq.MaSV,
                count(kq.MaSV) solg
FROM ketqua kq
GROUP BY kq.MaSV
ORDER BY count(kq.MaSV) DESC
LIMIT 3;

#60
SELECT DISTINCT MaMH,
                count(MaMH) slg
FROM ketqua kq
GROUP BY MaMH
ORDER BY MaMH
LIMIT 1;

#61
SELECT DISTINCT A.MaSV
FROM (SELECT DISTINCT MaSV, MaMH
      FROM quanlydiemsv.ketqua
      WHERE MaSV NOT LIKE ('A02')
      ORDER BY MaSV) AS A
         INNER JOIN
     (SELECT DISTINCT MaMH
      FROM ketqua kq
      WHERE MaSV = 'A02') AS B ON B.MaMH = A.MaMH;

#62
SELECT A.MaSV
FROM (SELECT DISTINCT MaSV, MaMH
      FROM quanlydiemsv.ketqua
      WHERE MaSV NOT LIKE ('A02')
      ORDER BY MaSV) AS A
WHERE A.MaMH = ALL
      (SELECT DISTINCT MaMH
       FROM ketqua kq
       WHERE MaSV = 'A02');