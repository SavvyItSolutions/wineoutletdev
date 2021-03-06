USE [Hangouts]
GO
/****** Object:  Table [dbo].[SKUDetails]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SKUDetails](
	[SKUId] [int] IDENTITY(1,1) NOT NULL,
	[SKU] [int] NOT NULL,
	[Name] [varchar](150) NOT NULL,
	[Vintage] [int] NULL,
	[Country] [varchar](50) NOT NULL,
	[Region] [varchar](150) NOT NULL,
	[Sub-Region] [varchar](150) NOT NULL,
	[GrapeVerietal] [varchar](150) NOT NULL,
	[Type] [varchar](150) NOT NULL,
	[SalePrice] [decimal](5, 2) NULL,
	[RegPrice] [decimal](5, 2) NULL,
	[TotalRating] [decimal](3, 2) NULL,
	[TotalUsersRated] [decimal](3, 2) NULL,
	[Description] [varchar](max) NULL,
	[BottleSize] [int] NOT NULL,
	[URI] [nvarchar](max) NULL,
	[LargeImageURL] [nvarchar](max) NULL,
	[Liked] [bit] NOT NULL,
	[Information] [nvarchar](max) NULL,
	[MoreInfo] [nvarchar](max) NULL,
	[Rating] [nvarchar](max) NULL,
	[TastingNotes] [nvarchar](max) NULL,
	[ReviewComments] [nvarchar](max) NULL,
 CONSTRAINT [PK_SKUDetails] PRIMARY KEY CLUSTERED 
(
	[SKUId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
