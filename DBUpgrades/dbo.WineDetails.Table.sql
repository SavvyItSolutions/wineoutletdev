USE [Hangouts]
GO
/****** Object:  Table [dbo].[WineDetails]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WineDetails](
	[DBKey] [int] IDENTITY(1,1) NOT NULL,
	[WineID] [int] NOT NULL,
	[TotalRating] [int] NULL,
	[TotalUsersRated] [int] NULL,
	[ProductDescription] [nvarchar](max) NULL,
	[AverageRating] [float] NULL,
	[BarCode] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
