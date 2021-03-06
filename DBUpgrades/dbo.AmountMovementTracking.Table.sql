USE [Hangouts]
GO
/****** Object:  Table [dbo].[AmountMovementTracking]    Script Date: 30-06-2017 07:57:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AmountMovementTracking](
	[dbKey] [int] IDENTITY(1,1) NOT NULL,
	[LastModifiedTime] [datetime] NOT NULL,
	[StoreId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[dbKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
