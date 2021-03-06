USE [Hangouts]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[ReviewID] [int] IDENTITY(1,1) NOT NULL,
	[PlantFinal] [varchar](4) NULL,
	[ReviewDate] [datetime] NOT NULL,
	[CardID] [int] NOT NULL,
	[Cost] [decimal](18, 4) NULL,
	[RatingStars] [int] NOT NULL,
	[SKU] [int] NULL,
	[CommentsTitle] [nvarchar](max) NULL,
	[RatingText] [nvarchar](max) NULL,
	[ReviewUserId] [int] NULL,
	[Name] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[WineId] [int] NOT NULL,
	[BarCode] [varchar](50) NULL,
 CONSTRAINT [PK_Reviews] PRIMARY KEY CLUSTERED 
(
	[ReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Reviews] ADD  DEFAULT ((0)) FOR [WineId]
GO
