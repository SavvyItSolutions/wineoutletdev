USE [Hangouts]
GO
/****** Object:  User [hangoutsadmin]    Script Date: 30-06-2017 07:57:27 PM ******/
CREATE USER [hangoutsadmin] FOR LOGIN [hangoutsadmin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [hangoutsadmin]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [hangoutsadmin]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [hangoutsadmin]
GO
ALTER ROLE [db_datareader] ADD MEMBER [hangoutsadmin]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [hangoutsadmin]
GO
