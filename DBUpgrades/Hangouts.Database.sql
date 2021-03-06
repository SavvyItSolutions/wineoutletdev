USE [master]
GO
/****** Object:  Database [Hangouts]    Script Date: 30-06-2017 07:57:24 PM ******/
CREATE DATABASE [Hangouts]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Hangouts', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Hangouts.mdf' , SIZE = 12288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Hangouts_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Hangouts_log.ldf' , SIZE = 35712KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Hangouts] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Hangouts].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Hangouts] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Hangouts] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Hangouts] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Hangouts] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Hangouts] SET ARITHABORT OFF 
GO
ALTER DATABASE [Hangouts] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Hangouts] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Hangouts] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Hangouts] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Hangouts] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Hangouts] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Hangouts] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Hangouts] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Hangouts] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Hangouts] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Hangouts] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Hangouts] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Hangouts] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Hangouts] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Hangouts] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Hangouts] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Hangouts] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Hangouts] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Hangouts] SET  MULTI_USER 
GO
ALTER DATABASE [Hangouts] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Hangouts] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Hangouts] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Hangouts] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Hangouts] SET  READ_WRITE 
GO
