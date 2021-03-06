USE [Hangouts]
GO
/****** Object:  Table [dbo].[Likes]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Likes](
	[LikeID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[SKU] [int] NOT NULL,
	[Liked] [bit] NOT NULL,
	[WineId] [int] NULL,
	[BarCode] [varchar](50) NULL,
 CONSTRAINT [PK_Likes] PRIMARY KEY CLUSTERED 
(
	[LikeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Likes] ADD  DEFAULT ((0)) FOR [WineId]
GO
