USE [master]
GO
/****** Object:  Database [QuanLyLaoDong]    Script Date: 6/28/2020 5:46:48 PM ******/
CREATE DATABASE [QuanLyLaoDong]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyLaoDong', FILENAME = N'F:\QuanLyLaoDong.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QuanLyLaoDong_log', FILENAME = N'F:\QuanLyLaoDong_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QuanLyLaoDong] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyLaoDong].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyLaoDong] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyLaoDong] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyLaoDong] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyLaoDong] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyLaoDong] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyLaoDong] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuanLyLaoDong] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyLaoDong] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyLaoDong] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyLaoDong] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyLaoDong] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyLaoDong] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyLaoDong] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyLaoDong] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyLaoDong] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyLaoDong] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyLaoDong] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyLaoDong] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyLaoDong] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyLaoDong] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyLaoDong] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyLaoDong] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyLaoDong] SET RECOVERY FULL 
GO
ALTER DATABASE [QuanLyLaoDong] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyLaoDong] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyLaoDong] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyLaoDong] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyLaoDong] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QuanLyLaoDong] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuanLyLaoDong', N'ON'
GO
ALTER DATABASE [QuanLyLaoDong] SET QUERY_STORE = OFF
GO
USE [QuanLyLaoDong]
GO
/****** Object:  UserDefinedFunction [dbo].[TuDongTangIDChucVu]    Script Date: 6/28/2020 5:46:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------
-- Tự động tăng ID Chuc vu
create function [dbo].[TuDongTangIDChucVu]()
returns char(5)
as
	begin
	declare @IDChucVu char(5)
	declare @SoChucVu int
	set @SoChucVu = (select count(ChucVu.IDChucVu) from ChucVu)
	if (@SoChucVu=0)
		set @IDChucVu='CV111'
	else 
		begin
			set @IDChucVu = RIGHT((select max(ChucVu.IDChucVu) from ChucVu),3)
			set @IDChucVu = CAST(@IDChucVu as int)+1
			set @IDChucVu = 'CV' + CAST(@SoChucVu as char(3))
		end
	return @IDChucVu
	end
GO
/****** Object:  UserDefinedFunction [dbo].[TuDongTangIDCongTrinh]    Script Date: 6/28/2020 5:46:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------
-- Tự động tăng ID cong trinh
create function [dbo].[TuDongTangIDCongTrinh]()
returns char(5)
as
	begin
	declare @IDCongTrinh char(5)
	declare @SoCogTrinh int
	set @SoCogTrinh=(select count([dbo].[CongTrinh].IDCongTrinh) from [dbo].[CongTrinh])
	if(@SoCogTrinh=0)
		begin
			set @SoCogTrinh='CT111'
		end
	else
		begin
			set @IDCongTrinh= RIGHT((select Max([dbo].[CongTrinh].IDCongTrinh) from [dbo].[CongTrinh]),3)
			set @SoCogTrinh= CAST(@SoCogTrinh as int)+1
			set @IDCongTrinh='HD'+CAST(@SoCogTrinh as char(3))
		end

	return @IDCongTrinh
	end
GO
/****** Object:  UserDefinedFunction [dbo].[TuDongTangIDNhanVien]    Script Date: 6/28/2020 5:46:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------
-- Tự động tăng ID NhanVien
create function [dbo].[TuDongTangIDNhanVien]()
returns char(5)
as
	begin
		declare @IDNhanVien char(5)
		declare @SoNhanVien int
		set @SoNhanVien = (select count(NhanVien.IDNhanVien) from NhanVien)
		if (@SoNhanVien=0)
			set @IDNhanVien='NV111'
		else 
			begin
				set @IDNhanVien = RIGHT((select max(NhanVien.IDNhanVien) from NhanVien),3)
				set @SoNhanVien = CAST(@IDNhanVien as int)+1
				set @IDNhanVien = 'NV' + CAST(@SoNhanVien as char(3))
			end
		return @IDNhanVien
	end
GO
/****** Object:  UserDefinedFunction [dbo].[TuDongTangIDPhongBan]    Script Date: 6/28/2020 5:46:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Tự động tăng ID PhongBan
create function [dbo].[TuDongTangIDPhongBan]()
returns char(5)
as
	begin
	declare @IDPhongBan char(5)
	declare @SoPhongBan int
	set @SoPhongBan=(select count([dbo].[PhongBan].IDPhongBan) from [dbo].[PhongBan])
	if(@SoPhongBan=0)
		set @IDPhongBan='PB111'
	else
		begin
			set @IDPhongBan =  RIGHT((select max([dbo].[PhongBan].IDPhongBan) from [dbo].[PhongBan]),3)
			set @SoPhongBan = CAST(@IDPhongBan as int)+1
			set @IDPhongBan = 'CC' + CAST(@SoPhongBan  as char(3))
		end
	return @IDPhongBan
	end
GO
/****** Object:  UserDefinedFunction [dbo].[TuDongTangIDTaiKhoan]    Script Date: 6/28/2020 5:46:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------
-- Tự động tăng ID TaiKhoan
create function [dbo].[TuDongTangIDTaiKhoan]()
returns char(5)
as
	begin
	declare @IDTaiKhoan char(5)
	declare @SoTaiKhoan int
	set @SoTaiKhoan = (select count(TaiKhoan.IDTaiKhoan) from TaiKhoan)
	if (@SoTaiKhoan=0)
		set @IDTaiKhoan='TK111'
	else 
		begin
			set @IDTaiKhoan = RIGHT((select max(TaiKhoan.IDTaiKhoan) from TaiKhoan),3)
			set @SoTaiKhoan = CAST(@IDTaiKhoan as int)+1
			set @IDTaiKhoan = 'TK' + CAST(@SoTaiKhoan as char(3))
		end
	return @IDTaiKhoan
	end
GO
/****** Object:  Table [dbo].[ChiTietCongTrinh]    Script Date: 6/28/2020 5:46:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietCongTrinh](
	[IDNhanVien] [char](5) NOT NULL,
	[IDCongTrinh] [char](5) NOT NULL,
	[NgayStart] [date] NULL,
	[NgayEnd] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDNhanVien] ASC,
	[IDCongTrinh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChucVu]    Script Date: 6/28/2020 5:46:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChucVu](
	[IDChucVu] [char](5) NOT NULL,
	[ChucVu] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDChucVu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CongTrinh]    Script Date: 6/28/2020 5:46:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CongTrinh](
	[IDCongTrinh] [char](5) NOT NULL,
	[TenCongTrinh] [nvarchar](40) NOT NULL,
	[DiaDiemCongTrinh] [nvarchar](40) NOT NULL,
	[NgayCapPhepXayDung] [date] NULL,
	[NgayKhoiCong] [date] NULL,
	[NgayHoanThanhTheoDuKien] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDCongTrinh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 6/28/2020 5:46:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[IDNhanVien] [char](5) NOT NULL,
	[HoTenNV] [nvarchar](40) NOT NULL,
	[IDPhongBan] [char](5) NOT NULL,
	[GioiTinh] [nvarchar](5) NULL,
	[NgaySinh] [date] NULL,
	[NgayLamViec] [date] NULL,
	[CMND] [nvarchar](9) NOT NULL,
	[DiaChi] [nvarchar](50) NULL,
	[Email] [nvarchar](30) NULL,
	[SDT] [nvarchar](15) NULL,
	[TinhTrang] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDNhanVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhongBan]    Script Date: 6/28/2020 5:46:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhongBan](
	[IDPhongBan] [char](5) NOT NULL,
	[TenPhongBan] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPhongBan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 6/28/2020 5:46:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[IDTaiKhoan] [char](5) NOT NULL,
	[TenTK] [nvarchar](28) NOT NULL,
	[MatKhau] [nvarchar](24) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ChiTietCongTrinh] ([IDNhanVien], [IDCongTrinh], [NgayStart], [NgayEnd]) VALUES (N'NV111', N'CT111', CAST(N'2019-01-01' AS Date), CAST(N'2020-01-01' AS Date))
GO
INSERT [dbo].[CongTrinh] ([IDCongTrinh], [TenCongTrinh], [DiaDiemCongTrinh], [NgayCapPhepXayDung], [NgayKhoiCong], [NgayHoanThanhTheoDuKien]) VALUES (N'CT111', N'Biet Thu', N'HCM', CAST(N'2019-01-01' AS Date), CAST(N'2019-01-02' AS Date), CAST(N'2020-01-01' AS Date))
INSERT [dbo].[CongTrinh] ([IDCongTrinh], [TenCongTrinh], [DiaDiemCongTrinh], [NgayCapPhepXayDung], [NgayKhoiCong], [NgayHoanThanhTheoDuKien]) VALUES (N'CT112', N'Nha O', N'Ha Noi', CAST(N'2020-03-01' AS Date), CAST(N'2020-03-10' AS Date), CAST(N'2020-03-30' AS Date))
INSERT [dbo].[CongTrinh] ([IDCongTrinh], [TenCongTrinh], [DiaDiemCongTrinh], [NgayCapPhepXayDung], [NgayKhoiCong], [NgayHoanThanhTheoDuKien]) VALUES (N'CT113', N'Haa', N'asdasdas', CAST(N'2020-05-02' AS Date), CAST(N'2020-05-11' AS Date), CAST(N'2020-05-26' AS Date))
GO
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTenNV], [IDPhongBan], [GioiTinh], [NgaySinh], [NgayLamViec], [CMND], [DiaChi], [Email], [SDT], [TinhTrang]) VALUES (N'NV111', N'Võ Văn Nghĩa', N'PB111', N'Nam', CAST(N'2001-10-10' AS Date), CAST(N'2010-10-10' AS Date), N'258964784', N'Hồ Chí Minh', N'VoVanNghia@gmail.com', N'0123456789', 1)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTenNV], [IDPhongBan], [GioiTinh], [NgaySinh], [NgayLamViec], [CMND], [DiaChi], [Email], [SDT], [TinhTrang]) VALUES (N'NV112', N'Nguyen Ha', N'PB111', N'Nam', CAST(N'1999-06-09' AS Date), CAST(N'2020-06-28' AS Date), N'123456789', N'0123456789', N'ha@gmail.com', N'0123456789', 1)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTenNV], [IDPhongBan], [GioiTinh], [NgaySinh], [NgayLamViec], [CMND], [DiaChi], [Email], [SDT], [TinhTrang]) VALUES (N'NV113', N'Nguyen Ha', N'PB111', N'Nam', CAST(N'1999-06-09' AS Date), CAST(N'2020-06-28' AS Date), N'123456789', N'0123456789', N'ha@gmail.com', N'0123456789', 1)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTenNV], [IDPhongBan], [GioiTinh], [NgaySinh], [NgayLamViec], [CMND], [DiaChi], [Email], [SDT], [TinhTrang]) VALUES (N'NV114', N'Ha', N'PB111', N'Nam', CAST(N'2001-06-06' AS Date), CAST(N'2020-06-28' AS Date), N'123456789', N'0123456789', N'asssas@gmail.com', N'0123456789', 1)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTenNV], [IDPhongBan], [GioiTinh], [NgaySinh], [NgayLamViec], [CMND], [DiaChi], [Email], [SDT], [TinhTrang]) VALUES (N'NV115', N'Nhật Long', N'PB111', N'Nam', CAST(N'2000-06-01' AS Date), CAST(N'2020-06-28' AS Date), N'123456789', N'0123456789', N'aaaaaaaa@gmail.com', N'0123456789', 1)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTenNV], [IDPhongBan], [GioiTinh], [NgaySinh], [NgayLamViec], [CMND], [DiaChi], [Email], [SDT], [TinhTrang]) VALUES (N'NV116', N'aaaaaaa', N'PB112', N'Nam', CAST(N'2001-06-01' AS Date), CAST(N'2020-06-28' AS Date), N'123456789', N'1234567890', N'sssssssssss@gmail.com', N'1234567890', 1)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTenNV], [IDPhongBan], [GioiTinh], [NgaySinh], [NgayLamViec], [CMND], [DiaChi], [Email], [SDT], [TinhTrang]) VALUES (N'NV117', N'Ha', N'PB112', N'Nam', CAST(N'2001-06-12' AS Date), NULL, N'123456781', N'HCM', N'ha@gmail.com', N'0123456467', 0)
GO
INSERT [dbo].[PhongBan] ([IDPhongBan], [TenPhongBan]) VALUES (N'PB111', N'Quan Ly')
INSERT [dbo].[PhongBan] ([IDPhongBan], [TenPhongBan]) VALUES (N'PB112', N'NhanVien')
GO
ALTER TABLE [dbo].[ChiTietCongTrinh]  WITH CHECK ADD FOREIGN KEY([IDCongTrinh])
REFERENCES [dbo].[CongTrinh] ([IDCongTrinh])
GO
ALTER TABLE [dbo].[ChiTietCongTrinh]  WITH CHECK ADD FOREIGN KEY([IDNhanVien])
REFERENCES [dbo].[NhanVien] ([IDNhanVien])
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD FOREIGN KEY([IDPhongBan])
REFERENCES [dbo].[PhongBan] ([IDPhongBan])
GO
USE [master]
GO
ALTER DATABASE [QuanLyLaoDong] SET  READ_WRITE 
GO
