USE [master]
GO
/****** Object:  Database [FoodDelivery]    Script Date: 04/07/2024 05:59:50 ******/
CREATE DATABASE [FoodDelivery]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FoodDelivery', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\FoodDelivery.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FoodDelivery_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\FoodDelivery.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [FoodDelivery] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FoodDelivery].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FoodDelivery] SET ANSI_NULL_DEFAULT ON 
GO
ALTER DATABASE [FoodDelivery] SET ANSI_NULLS ON 
GO
ALTER DATABASE [FoodDelivery] SET ANSI_PADDING ON 
GO
ALTER DATABASE [FoodDelivery] SET ANSI_WARNINGS ON 
GO
ALTER DATABASE [FoodDelivery] SET ARITHABORT ON 
GO
ALTER DATABASE [FoodDelivery] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FoodDelivery] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FoodDelivery] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FoodDelivery] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FoodDelivery] SET CURSOR_DEFAULT  LOCAL 
GO
ALTER DATABASE [FoodDelivery] SET CONCAT_NULL_YIELDS_NULL ON 
GO
ALTER DATABASE [FoodDelivery] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FoodDelivery] SET QUOTED_IDENTIFIER ON 
GO
ALTER DATABASE [FoodDelivery] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FoodDelivery] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FoodDelivery] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FoodDelivery] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FoodDelivery] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FoodDelivery] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FoodDelivery] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FoodDelivery] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FoodDelivery] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FoodDelivery] SET RECOVERY FULL 
GO
ALTER DATABASE [FoodDelivery] SET  MULTI_USER 
GO
ALTER DATABASE [FoodDelivery] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FoodDelivery] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FoodDelivery] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FoodDelivery] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FoodDelivery] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FoodDelivery] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [FoodDelivery] SET QUERY_STORE = ON
GO
ALTER DATABASE [FoodDelivery] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [FoodDelivery]
GO
/****** Object:  Table [dbo].[dishes]    Script Date: 04/07/2024 05:59:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dishes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](30) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[Price] [float] NOT NULL,
	[Nutritional values] [nvarchar](250) NOT NULL,
	[Image] [nvarchar](100) NULL,
	[Vegan] [bit] NOT NULL,
	[restaurant_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_dishes]    Script Date: 04/07/2024 05:59:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_dishes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_order] [int] NOT NULL,
	[id_dish] [int] NOT NULL,
	[quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 04/07/2024 05:59:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[client_id] [int] NOT NULL,
	[date_of_order] [datetime] NOT NULL,
	[rest_id] [int] NOT NULL,
	[price] [float] NOT NULL,
	[adress_delivered] [nvarchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[restaurants]    Script Date: 04/07/2024 05:59:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[restaurants](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [char](30) NOT NULL,
	[Location] [nchar](30) NOT NULL,
	[Address] [nvarchar](150) NOT NULL,
	[Monday-Friday_Open] [time](7) NOT NULL,
	[Monday-Friday_Close] [time](7) NOT NULL,
	[Saturday-Sunday_Open] [time](7) NOT NULL,
	[Saturday-Sunday_Close] [time](7) NOT NULL,
	[Image] [nvarchar](200) NULL,
	[Date fiscale] [nvarchar](400) NULL,
	[Logo] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_Credentials]    Script Date: 04/07/2024 05:59:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_Credentials](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[Salt] [varbinary](64) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_Details]    Script Date: 04/07/2024 05:59:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_Details](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[Admin] [bit] NULL,
	[user_id] [int] NOT NULL,
	[AdditionalAddresses] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_Session]    Script Date: 04/07/2024 05:59:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_Session](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[SessionId] [nvarchar](255) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ExpiresAt] [datetime] NOT NULL,
	[UserID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[dishes] ON 

INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (1, N'Shaorma mare                  ', N'Carne doner piept de pui/pulpă pui, varză, roșii, sos-uri,catraveti murați, castraveți, cartofi prăjiți, salată, lipie.
650 g', 41.86, N'Valori nutriționale
Valoare Energetica: 1.852,72 KJ 2. Valoare Energetica: 442,81 Kcal 3. Grasimi: 35,67g 3,5. Din care acizi grasi: 4,26g 4. Glucide: 62,28g 4,5. Din care zaharuri: 2g 5. Proteine: 35,20g 6. Sare: 3,84g', N'shaorma_1.jpg', 0, 1)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (5, N'Shaorma mică                  ', N'Carne doner piept de pui/pulpă pui, varză, roșii, sos-uri catraveti murați, castraveți, cartofi prăjiți, salată, lipie.
450 g ', 36.4, N'Valori nutriționale
Valoare Energetica: 1.574,74 KJ 2. Valoare Energetica: 379,81 Kcal 3. Grasimi: 33g 3,5. Din care acizi grasi: 3,9g 4. Glucide: 39,28g 4,5. Din care zaharuri: 1,8g 5. Proteine: 27,44g 6. Sare: 2,4g', N'shaorma_1.jpg', 0, 1)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (6, N'Meniu mici                    ', N'Carne vită-oaie / 6 mititei + mustar ', 37, N'Valori nutriționale
Mici 100g 1. Valoare Energetica: 605 KJ 2. Valoare Energetica: 144.68 Kcal 3. Grasimi: 6.76g 3,5. Din care acizi grasi: 3,7g 4. Glucide: 3.7g 4,5. Din care zaharuri: 1.07g 5. Proteine: 17.26g 6. Sare: 1.8g', N'mici_1.jpg', 0, 1)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (7, N'Meniu Nuggets crispy          ', N'Nuggets de pui sau crispy de pui, sos, cartofi prăjiți, chiflă', 38.22, N'Valori nutriționale
Nuggets / Crispy 1. Valoare Energetica: 2.702 KJ 2. Valoare Energetica: 649.2 Kcal 3. Grasimi: 13.9g 3,5. Din care acizi grasi: 3,5g 4. Glucide: 97.9g 4,5. Din care zaharuri: 11.1g 5. Proteine: 31g 6. Sare: 3g', N'nuggets_1.jpg', 0, 1)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (9, N'Doner pui                     ', N'Carne doner piept de pui/pulpă pui, varză, roșii, sos-uri,catraveti murați, castraveți, cartofi prăjiți, salată, chiflă doner.
550 g', 30, N'Valori nutriționale
1. Valoare Energetica: 2.121,47 KJ 2. Valoare Energetica: 507 Kcal 3. Grasimi: 22,48g 3,5. Din care acizi grasi: 2g 4. Glucide: 50,3g 4,5. Din care zaharuri: 3,1g 5. Proteine: 28,16g 6. Sare: 4,1g', N'donner_1.jpg', 0, 1)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (10, N'L`gustos burger               ', N'Carne de vită, sos-uri, brânză cheddar, castraveți murați:ceapă / dulce, ceapă prăjită, chiflă, salată, cartofi
500 g', 41, N'Valori nutriționale
L’GUSTOS Burger 100g 1. Valoare Energetica: 906,70KJ 2. Valoare Energetica: 216,58Kcal 3. Grasimi: 16,31g 3,5. Din care acizi grasi: 6,1g 4. Glucide: 5,61g 4,5. Din care zaharuri: 1,46g 5. Proteine: 10.15g 6. Sare: 1,55g', N'burger_1.jpg', 0, 1)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (11, N'Fanta                         ', N'Fanta la doza 330ml', 8, N'Valoare energetică183kJ / 43kcal
Grăsimi0g
Glucide10,5g
din care zaharuri10,5g
Proteine0g
Sare0g', N'fanta.jpg', 0, 1)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (12, N'Cola                          ', N'Cola doza 330ml', 8, N'Valoare energetică183kJ / 43kcal
Grăsimi0g
Glucide10,5g
din care zaharuri10,5g
Proteine0g
Sare0g', N'cola.jpg', 0, 1)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (13, N'Sprite                        ', N'Sprite doza 330ml', 8, N'Valoare energetică183kJ / 43kcal
Grăsimi0g
Glucide10,5g
din care zaharuri10,5g
Proteine0g
Sare0g', N'sprite.jpg', 0, 1)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (16, N'Redbull                       ', N'Redbull doza 330ml', 10, N'Energie
195 kJ / 46 kcal
Proteine
0 g
Carbohidrați
11 g
din care zaharuri
11 g
Grăsimi
0 g
Of which Saturates
0 g
Fibre
0 g
Sare
0,1 g', N'redbull.jpg', 0, 1)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (17, N'Pizza Maestro                 ', N'Sos pizza, mozzarela, șuncă presată, salam, mușchi file, ciuperci, măsline, ardei', 35, N'Valori nutriționale pentru 100 grame:
Valoare energetică: 348,62 Kcal / 1457,23 Kj, Grăsimi: 11,86 g, Acizi Grași Saturați: 6,4 g, Glucide: 40,28 g, Zaharuri: 2,74 g, Proteine: 19,52 g, Sare: 2,55 g.', N'pizza_maestro_2.jpg', 0, 2)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (18, N'Pizza Quattro Stagioni        ', N'Sos pizza, topping pizza, șuncă presată, salam, ciuperci, măsline', 35, N'Valori nutriționale pentru 100 grame:
Valoare energetică: 348,62 Kcal / 1457,23 Kj, Grăsimi: 11,86 g, Acizi Grași Saturați: 6,4 g, Glucide: 40,28 g, Zaharuri: 2,74 g, Proteine: 19,52 g, Sare: 2,55 g.', N'pizza_quatro_2.jpg', 0, 2)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (20, N'Pizza Capriciosa              ', N'Sos pizza, topping pizza, șuncă presată, ciuperci, măsline', 36, N'Valori nutriționale pentru 100 grame:
Valoare energetică: 348,62 Kcal / 1457,23 Kj, Grăsimi: 11,86 g, Acizi Grași Saturați: 6,4 g, Glucide: 40,28 g, Zaharuri: 2,74 g, Proteine: 19,52 g, Sare: 2,55 g.', N'pizza_capriciosa_2.jpg', 0, 2)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (21, N'Pizza Salami                  ', N'Sos pizza, topping pizza, salam', 34, N'Valori nutriționale pentru 100 grame:
Valoare energetică: 348,62 Kcal / 1457,23 Kj, Grăsimi: 11,86 g, Acizi Grași Saturați: 6,4 g, Glucide: 40,28 g, Zaharuri: 2,74 g, Proteine: 19,52 g, Sare: 2,55 g.', N'salami_2.jpg', 0, 2)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (22, N'Pizza Quattro Formaggi        ', N'Sos pizza, topping pizza, brânză tare rasă(parmesan), brânză cu mucegai', 32, N'Valori nutriționale pentru 100 grame:
Valoare energetică: 348,62 Kcal / 1457,23 Kj, Grăsimi: 11,86 g, Acizi Grași Saturați: 6,4 g, Glucide: 40,28 g, Zaharuri: 2,74 g, Proteine: 19,52 g, Sare: 2,55 g.', N'quatro_form_2.jpg', 0, 2)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (23, N'Pizza Diavolo                 ', N'Sos pizza, topping pizza, salam, ardei, chili', 36, N'Valori nutriționale pentru 100 grame:
Valoare energetică: 348,62 Kcal / 1457,23 Kj, Grăsimi: 11,86 g, Acizi Grași Saturați: 6,4 g, Glucide: 40,28 g, Zaharuri: 2,74 g, Proteine: 19,52 g, Sare: 2,55 g.', N'diavola_2.jpg', 0, 2)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (24, N'Pulpa pui cu orez si legume   ', N'Pulpa pui cu orez si legume, 500g', 33, N'Valori nutritionale / portie (350g) Valoare energetica: 586.64 KCal /2454.49 Kj , Grasimi: 48.47 g, Acizi grasi saturati: 5.39 g, Glucide: 33.08 g, Zaharuri: 3.69 g, Proteine: 5.11 g, Sare: 0.02 g', N'pulpe_orez_3.jpg', 0, 3)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (29, N'Tocanita de cartofi           ', N'Ingrediente
Cantitate ingrediente pentru o portie Cartofi: 150 g , Suc de rosii: 100 g , Ceapa noua: 50 g , Ulei: 50 g , Usturoi: 10 g', 30, N'Valori nutritionale / 100g Valoare energetica: 167.61 KCal /701.28 Kj , Grasimi: 13.85 g, Acizi grasi saturati: 1.54 g, Glucide: 9.45 g, Zaharuri: 1.06 g, Proteine: 1.46 g, Sare: 0.01 g', N'tocana_Cartofi_3.jpg', 1, 3)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (31, N'Tocana de mazare de post      ', N'Ingrediente 
Cantitate ingrediente pentru o portie Mazare conserva: 200 g , Cartofi: 150 g , Suc de rosii: 50 g , Ceapa: 30 g , Ulei: 20 g', 28, N'Valori nutritionale / portie (380g) Valoare energetica: 348.76 KCal /1459.18 Kj , Grasimi: 17.38 g, Acizi grasi saturati: 2.05 g, Glucide: 40.53 g, Zaharuri: 9.04 g, Proteine: 8.18 g, Sare: 0.44 g ', N'mazare_3.jpg', 1, 3)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (32, N'Prajitura Alba ca zapada      ', N'Prajitura Alba ca zapada', 9, N'Valori nutritionale / 100g Valoare energetica: 91.78 KCal /384 Kj , Grasimi: 4.57 g, Acizi grasi saturati: 0.54 g, Glucide: 10.67 g, Zaharuri: 2.38 g, Proteine: 2.15 g, Sare: 0.12 g', N'praj_alba_3.jpg', 0, 3)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (34, N'Clatite cu mere la cuptor     ', N'Clatite cu mere la cuptor', 14, N'Valori nutritionale / 100g Valoare energetica: 91.78 KCal /384 Kj , Grasimi: 4.57 g, Acizi grasi saturati: 0.54 g, Glucide: 10.67 g, Zaharuri: 2.38 g, Proteine: 2.15 g, Sare: 0.12 g', N'clatite_mere_3.jpg', 0, 3)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (35, N'Ostropel de pui cu mămăliguță ', N'Ingrediente
Cantitate ingrediente pentru o portie Pulpa de pui lidl: 220 g , Suc de rosii: 150 g , Malai superior: 120 g , Usturoi: 50 g', 30, N'Valori nutriționale
Valori nutritionale / portie (470g) Valoare energetica: 709 KCal /2966.47 Kj , Grasimi: 13.99 g, Acizi grasi saturati: 4.37 g, Glucide: 98.87 g, Zaharuri: 3.9 g, Proteine: 46.74 g, Sare: 0.41 g ', N'ostropel_mamaliga_3.jpg', 0, 3)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (36, N'Kebab pui                     ', N'Roșii, castraveți, castraveți murați, ceapă albă /roșie mix pătrunjel, salată de varză albă / roșie, salată verde, cartofi
 350 g', 24, N'Valori nutriționale pentru 100 grame:
Valoare energetică: 348,62 Kcal / 1457,23 Kj, Grăsimi: 11,86 g, Acizi Grași Saturați: 6,4 g, Glucide: 40,28 g, Zaharuri: 2,74 g, Proteine: 19,52 g, Sare: 2,55 g.', N'kebab_pui_5.jpg', 0, 5)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (38, N'Kebab vită                    ', N'Roșii, castraveți, castraveți murați, ceapă albă /roșie mix pătrunjel, salată de varză albă / roșie, salată verde, cartofi', 28, N'Valori nutriționale pentru 100 grame:
Valoare energetică: 348,62 Kcal / 1457,23 Kj, Grăsimi: 11,86 g, Acizi Grași Saturați: 6,4 g, Glucide: 40,28 g, Zaharuri: 2,74 g, Proteine: 19,52 g, Sare: 2,55 g.', N'kebab_pui_5.jpg', 0, 5)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (39, N'Meniu Crispy Farfurie         ', N'5 Crispy Strips plus cartofi prajiti, salata si sosuri la alegere 250 g / 150g', 32, N'Valori nutriționale pentru 100 grame:
Valoare energetică: 348,62 Kcal / 1457,23 Kj, Grăsimi: 11,86 g, Acizi Grași Saturați: 6,4 g, Glucide: 40,28 g, Zaharuri: 2,74 g, Proteine: 19,52 g, Sare: 2,55 g.', N'crispy_farf_5.jpg', 0, 5)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (40, N'Bucket Crispy Strips          ', N'12 crispy strips plus 2 portii cartofi prajiti, salata si sosuri la alegere 600 g/ 300g ', 70, N'Valori nutriționale pentru 100 grame:
Valoare energetică: 348,62 Kcal / 1457,23 Kj, Grăsimi: 11,86 g, Acizi Grași Saturați: 6,4 g, Glucide: 40,28 g, Zaharuri: 2,74 g, Proteine: 19,52 g, Sare: 2,55 g.', N'bucket_Crispy_5.jpg', 0, 5)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (41, N'Baghetă Pui                   ', N'Roșii, castraveți, castraveți murați, ceapă albă /roșie mix pătrunjel, salată de varză albă / roșie, salată verde, cartofi', 23, N'Valori nutriționale pentru 100 grame:
Valoare energetică: 348,62 Kcal / 1457,23 Kj, Grăsimi: 11,86 g, Acizi Grași Saturați: 6,4 g, Glucide: 40,28 g, Zaharuri: 2,74 g, Proteine: 19,52 g, Sare: 2,55 g.', N'bagheta_5.jpg', 0, 5)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (42, N'Baghetă Mixt                  ', N'Roșii, castraveți, castraveți murați, ceapă albă /roșie mix pătrunjel, salată de varză albă / roșie, salată verde, cartofi
250 g', 25, N'Valori nutriționale pentru 100 grame:
Valoare energetică: 348,62 Kcal / 1457,23 Kj, Grăsimi: 11,86 g, Acizi Grași Saturați: 6,4 g, Glucide: 40,28 g, Zaharuri: 2,74 g, Proteine: 19,52 g, Sare: 2,55 g.', N'bagheta_5.jpg', 0, 5)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (43, N'Shaorma farfurie mixt         ', N'Shaorma farfurie mixt, 400g', 33, N'Valori nutriționale pentru 100 grame:
Valoare energetică: 348,62 Kcal / 1457,23 Kj, Grăsimi: 11,86 g, Acizi Grași Saturați: 6,4 g, Glucide: 40,28 g, Zaharuri: 2,74 g, Proteine: 19,52 g, Sare: 2,55 g.', N'shaorma_farf_5.jpg', 0, 5)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (47, N'Ouă prăjite                   ', N'Ouă prăjite cu cartofi dippers, bacon și sos ceddar 
Ingrediente', 29, N'Alergeni
OUĂ, SOIA, LACTATE', N'oua_7.jpg', 0, 7)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (50, N'Salată caesar                 ', N'Salată iceberg 130g, piept de pui 100g, bacon afumat* 45g, ou fiert 60g, grana duro 15g, crutoane 20g, dressing pe bază de maioneză 50g, sare, piper. ', 30, N'Valori nutriționale
Valoare Energetică: 665 Kcal/2782,36 Kj, Grăsimi: 42g, Acizi Grași Saturați: 8g, Proteine: 49g, Glucide: 22g, Zaharuri: 3g, Sodiu: 1,2g.
Alergeni
GLUTEN, OUĂ, SOIA, LACTATE, MUSTAR.', N'salata_caesar_7.jpg', 0, 7)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (51, N'Pachețele de primăvară        ', N'Ingrediente
Pachețele de primăvară cu legume** 200g , sos sweet chilly, sos soia, sos sriracha. E621, E150a', 31, N'Valori nutriționale
Valoare Energetică/porție: 462 Kcal/1933 Kj, Grăsimi: 22g, Acizi Grași Saturați: 2g, Proteine: 11g, Glucide: 51g, Zaharuri: 10g, Sodiu: 1,2g.
Alergeni
GLUTEN, LACTATE, SUSAN.', N'pachetele_7.jpg', 1, 7)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (53, N'Ciorbă de văcuță              ', N'Ingrediente 
Carne de văcuță 50g, morcovi, țelină, ceapă, cartofi, pătrunjel, ou, sare, piper, servită cu smântână 50g și ardei iute murat. ', 22, N'Valori nutriționale
 Valoare Energetică: 227 Kcal/949,76 Kj, Grăsimi: 13g, Acizi Grași Saturați: 9g, Proteine: 16g, Glucide: 7g, Zaharuri: 2g, Sodiu: 2,3g.
Alergeni
OUĂ, ȚELINĂ, LACTATE.', N'ciorba_vacuta_7.jpg', 0, 7)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (55, N'Cheeseburger                  ', N'Ingrediente 
Chiflă 90g, cartofi prăjiți** 100g, carne tocată de vită 200g, condimente, ceddar 20g, castraveți murațI 40g, roșie 40g, salată lollo bionda 20g, sos bbq 50g, maioneză 50g. ', 40, N'Valori nutriționale
Valoare Energetică/porție: 1176 Kcal/4920,38 Kj, Grăsimi: 49g, Acizi Grași Saturați: 5g, Proteine: 51g, Glucide: 110g, Zaharuri: 7g, Sodiu: 3,2g.
Alergeni
GLUTEN, OUĂ, LACTATE, MUȘTAR, SUSAN.', N'cheeseburger_7.jpg', 0, 7)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (57, N'Burger chicken                ', N'Ingrediente
Chiflă** 90g, cartofi dippers** 100g, chiftea din piept de pui** 150g, roșii 40g, castraveți murați 40g, salată lollo bionda 20g, ceapă roșie 10g, sos bbq 50g.', 40, N'Valori nutriționale
Valoare Energetică: 1032 Kcal/4317,88 Kj, Grăsimi: 50g, Acizi Grași Saturați: 6g, Proteine: 51g, Glucide: 95g, Zaharuri: 7g, Sodiu: 1,8g.
Alergeni
GLUTEN, OUĂ, SOIA, LACTATE, MUȘTAR, SUSAN.', N'burger_chicken_7.jpg', 0, 7)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (58, N'Spaghette carbonara           ', N'Ingrediente
Spaghete* 200g, smântână de gătit 100ml, bacon afumat* 80g, grana duro 30g, sare, piper.', 36, N'Valori nutriționale
Valoare Energetică/porție: 740 Kcal/3098,06 Kj, Grăsimi: 49g, Acizi Grași Saturați: 19g, Proteine: 32g, Glucide: 76g, Zaharuri: 6g, Sodiu: 3,4g.
Alergeni
GLUTEN, SOIA, LACTATE.', N'carbonara_7.jpg', 0, 7)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (59, N'Penne con pollo               ', N'Ingrediente
Penne* 200g, piept de pui** 100g, ardei gras 80g, sos de roșii 100g, ulei de măsline 10ml, sare, piper.', 33, N'Valori nutriționale
Valoare Energetică/porție: 492 Kcal/2058,52 Kj, Grăsimi: 10,5g, Acizi Grași Saturați: 2g, Proteine: 32g, Glucide: 66g, Zaharuri: 3g, Sodiu: 1,4g.
Alergeni
GLUTEN.', N'pene_con_7.jpg', 0, 7)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (62, N'Tacos pui                     ', N'Ingrediente
Ingrediente : lipie tortilla, piept pui marinat, piper negru, sare de masă iodată, cartofi prăjiți, sos de brânză home-made, piper negru, sare, sos tacos la alegere. ', 20, N'Declaratie nutritionala/100g: Energie Kcal 295.78. Energie Kj 1237.54. Grasimi 16.23g, din care acizi grasi saturati 3.76g. Glucide 24.42g, din care zaharuri 2.48g. Fibre 1.4g. Proteine 10.3g. Sare 0.8g.', N'taco_pui_10.jpg', 0, 10)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (63, N'Tacos Crispy                  ', N'Ingrediente: lipie tortilla, strips piept pui nepicant, cartofi prăjiți ,sos de brânză home-made, piper negru, sare de masa iodata, sos tacos.', 23, N'Declaratie nutritionala/100g: Energie Kcal 345.86. Energie Kj 1447.07. Grasimi 21.32g, din care acizi grasi saturati 4.51g. Glucide 29.31g, din care zaharuri 3.45g. Fibre 1.09g. Proteine 6.23g. Sare 0.76g.', N'taco_crispy_10.jpg', 0, 10)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (65, N'Tacos Cordon Bleu             ', N'Ingrediente: lipie tortilla, cordon bleu, cartofi prajiti, sos de brânză home-made, piper negru, sare de masa iodata), sos tacos ', 24, N'Declaratie nutritionala/100g: Energie Kcal 331.06. Energie Kj 1385.15. Grasimi 21.06g, din care acizi grasi saturati 5.02g. Glucide 25.73g, din care zaharuri 3.19g. Fibre 1.09g. Proteine 6.74g. Sare 0.76g.', N'taco_cordon_10.jpg', 0, 10)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (66, N'Tacos vita Black Angus        ', N'ngrediente: lipie tortilla , carne tocata vita black angus, cartofi prăjiți, sos de brânză home-made, piper negru, sare de masa iodata, sos tacos la alegere.', 24, N'Declaratie nutritionala/100g: Energie Kcal 370.63. Energie Kj 1550.71. Grasimi 26.94g, din care acizi grasi saturati 6.55g. Glucide 23.18g, din care zaharuri 2.43g. Fibre 1.09g. Proteine 6.74g. Sare 1.01g.', N'tacos_black_10.jpg', 0, 10)
INSERT [dbo].[dishes] ([Id], [Name], [Description], [Price], [Nutritional values], [Image], [Vegan], [restaurant_id]) VALUES (67, N'Tacos Falafel                 ', N'ngrediente
Lipie tortilla, falafel, cartofi prăjiți, sos de brânză home-made, piper negru, sare de masa iodata, sos tacos', 23, N'Declaratie nutritionala/100g: Energie Kcal 348.16. Energie Kj 1456.70. Grasimi 23.36g, din care acizi grasi saturati 4.51g. Glucide 26.5g, din care zaharuri 3.45g. Fibre 1.09g. Proteine 4.95g. Sare 0.76g.', N'tacos_falafel_23.jpg', 0, 10)
SET IDENTITY_INSERT [dbo].[dishes] OFF
GO
SET IDENTITY_INSERT [dbo].[order_dishes] ON 

INSERT [dbo].[order_dishes] ([id], [id_order], [id_dish], [quantity]) VALUES (1, 7, 5, 2)
INSERT [dbo].[order_dishes] ([id], [id_order], [id_dish], [quantity]) VALUES (2, 8, 5, 2)
INSERT [dbo].[order_dishes] ([id], [id_order], [id_dish], [quantity]) VALUES (3, 8, 6, 1)
INSERT [dbo].[order_dishes] ([id], [id_order], [id_dish], [quantity]) VALUES (4, 9, 1, 2)
INSERT [dbo].[order_dishes] ([id], [id_order], [id_dish], [quantity]) VALUES (5, 10, 5, 5)
INSERT [dbo].[order_dishes] ([id], [id_order], [id_dish], [quantity]) VALUES (6, 10, 1, 4)
SET IDENTITY_INSERT [dbo].[order_dishes] OFF
GO
SET IDENTITY_INSERT [dbo].[orders] ON 

INSERT [dbo].[orders] ([id], [client_id], [date_of_order], [rest_id], [price], [adress_delivered]) VALUES (7, 1, CAST(N'2024-07-04T00:30:50.803' AS DateTime), 1, 72.8, N'string')
INSERT [dbo].[orders] ([id], [client_id], [date_of_order], [rest_id], [price], [adress_delivered]) VALUES (8, 1, CAST(N'2024-07-04T00:52:19.433' AS DateTime), 1, 37, N'string')
INSERT [dbo].[orders] ([id], [client_id], [date_of_order], [rest_id], [price], [adress_delivered]) VALUES (9, 1, CAST(N'2024-07-04T05:33:20.030' AS DateTime), 1, 83.72, N'alabala')
INSERT [dbo].[orders] ([id], [client_id], [date_of_order], [rest_id], [price], [adress_delivered]) VALUES (10, 1, CAST(N'2024-07-04T05:35:29.280' AS DateTime), 1, 167.44, N'alabala')
SET IDENTITY_INSERT [dbo].[orders] OFF
GO
SET IDENTITY_INSERT [dbo].[restaurants] ON 

INSERT [dbo].[restaurants] ([Id], [Name], [Location], [Address], [Monday-Friday_Open], [Monday-Friday_Close], [Saturday-Sunday_Open], [Saturday-Sunday_Close], [Image], [Date fiscale], [Logo]) VALUES (1, N'L''Gustos                      ', N'Constanța                     ', N'JUD. CONSTANŢA, MUN. CONSTANŢA, STR. POPORULUI, NR.36, ET.2', CAST(N'11:00:00' AS Time), CAST(N'00:00:00' AS Time), CAST(N'10:00:00' AS Time), CAST(N'22:00:00' AS Time), N'l''gustos locatie.jpg', N'Date fiscale 
Denumire societate: LGUSTOS SRL
CUI: 49229652
Reg. com: J13/4010/2023
Adresa: JUD. CONSTANŢA, MUN. CONSTANŢA, STR. POPORULUI, NR.36, ET.2
Comerciant', N'l''gustos logo.jpg')
INSERT [dbo].[restaurants] ([Id], [Name], [Location], [Address], [Monday-Friday_Open], [Monday-Friday_Close], [Saturday-Sunday_Open], [Saturday-Sunday_Close], [Image], [Date fiscale], [Logo]) VALUES (2, N'Pizza Maestro                 ', N'Constanța                     ', N'10 Strada Bogdan Petriceicu Hașdeu', CAST(N'10:30:00' AS Time), CAST(N'22:45:00' AS Time), CAST(N'10:30:00' AS Time), CAST(N'22:45:00' AS Time), N'pizza maestro locatie.jpg', N'Date fiscale 
Denumire societate: CATERA PREMIUM DELIVERY SRL
CUI: RO40360645
Reg. com: J13/3871/2018
Adresa: JUD. CONSTANŢA, MUN. CONSTANŢA, STR. BOGDAN PETRICEICU HAŞDEU, NR.12
Comerciant', N'pizza maestro logo.jpg')
INSERT [dbo].[restaurants] ([Id], [Name], [Location], [Address], [Monday-Friday_Open], [Monday-Friday_Close], [Saturday-Sunday_Open], [Saturday-Sunday_Close], [Image], [Date fiscale], [Logo]) VALUES (3, N'Gusturi locale din Bucovina   ', N'Constanța                     ', N'Str. Zorelelor, Nr. 67, Corp A', CAST(N'10:00:00' AS Time), CAST(N'22:00:00' AS Time), CAST(N'10:00:00' AS Time), CAST(N'22:00:00' AS Time), N'gusturi_bucovina_locatie.jpg', N'Date fiscale
 Denumire societate: PROFESIONAL CHEFS SRL
CUI: RO36676896
Reg. com: J13/2565/2016
Adresa: JUD. CONSTANŢA, SAT LUMINA COM. LUMINA, STR. CRIZANTEMELOR, NR.1
Comerciant', N'gusturi_bucovina_logo.jpg')
INSERT [dbo].[restaurants] ([Id], [Name], [Location], [Address], [Monday-Friday_Open], [Monday-Friday_Close], [Saturday-Sunday_Open], [Saturday-Sunday_Close], [Image], [Date fiscale], [Logo]) VALUES (5, N'Konak Turcesc                 ', N'Constanța                     ', N'204B Bulevardul I. C. Brătianu', CAST(N'09:15:00' AS Time), CAST(N'22:00:00' AS Time), CAST(N'10:00:00' AS Time), CAST(N'21:00:00' AS Time), N'konak locatie.jpg', N'Date fiscale
Denumire societate: KAYA PROFESIONAL BET S.R.L.
CUI: RO45875936
Reg. com: J13/1052/2022
Adresa: JUD. CONSTANŢA, MUN. CONSTANŢA, BLD. I. C. BRĂTIANU, NR.204B
Comerciant
Obiecte de activitate, autorizații și certificate
Autoritatea nationala sanitar veterinara si pentru siguranta alimentelorNR. VA26.928 din 14.07.2023
Autorizatie de functionare 1021 din 23.10.2023', N'konak_logo.jpg')
INSERT [dbo].[restaurants] ([Id], [Name], [Location], [Address], [Monday-Friday_Open], [Monday-Friday_Close], [Saturday-Sunday_Open], [Saturday-Sunday_Close], [Image], [Date fiscale], [Logo]) VALUES (7, N'ROKA Bistro                   ', N'Constanța                     ', N'Strada Frunzelor bl. R10', CAST(N'12:00:00' AS Time), CAST(N'22:30:00' AS Time), CAST(N'10:00:00' AS Time), CAST(N'22:30:00' AS Time), N'roka_locatie.jpg', N'Date fiscale
Denumire societate: PREST SERV TEAM SRL
CUI: RO35247322
Reg. com: J13/2486/2015
Adresa: JUD. CONSTANŢA, ORŞ. NĂVODARI, STR. VIORELEI, NR.6
C omerciant', N'roka_logo.jpg')
INSERT [dbo].[restaurants] ([Id], [Name], [Location], [Address], [Monday-Friday_Open], [Monday-Friday_Close], [Saturday-Sunday_Open], [Saturday-Sunday_Close], [Image], [Date fiscale], [Logo]) VALUES (10, N'Tacoseria                     ', N'Constanța                     ', N'Aleea Garofitei, 24b', CAST(N'11:00:00' AS Time), CAST(N'22:45:00' AS Time), CAST(N'11:00:00' AS Time), CAST(N'22:45:00' AS Time), N'tacoserie_locatie.jpg', N'Date fiscale
Denumire societate: Superfood Network SRL
CUI: RO47742006
Reg. com: J13/732/2023
Adresa: JUD. CONSTANŢA, MUN. CONSTANŢA, ALEEA GAROFIŢEI, NR.24B, SPATIUL COMERCIAL NR.7-9, PIATA AGROALIMENTARA
Comerciant', N'tacoserie_logo.jpg')
SET IDENTITY_INSERT [dbo].[restaurants] OFF
GO
SET IDENTITY_INSERT [dbo].[user_Credentials] ON 

INSERT [dbo].[user_Credentials] ([id], [Email], [Password], [Salt]) VALUES (1, N'stefan@gmail.com', N'yfk6Kjh/W2VfZ7e5s30M7VBqNUhvU01IZJC79hUcms0=', 0x4946116662807EC8637CB717B3D09D3A)
INSERT [dbo].[user_Credentials] ([id], [Email], [Password], [Salt]) VALUES (2, N'string@yahoo.com', N'Meaw/KkYSM8kvLS2FuxOdrKIGgUm98OzS86he4bLLIk=', 0x976F5026AC973925E6067696CA523814)
SET IDENTITY_INSERT [dbo].[user_Credentials] OFF
GO
SET IDENTITY_INSERT [dbo].[user_Details] ON 

INSERT [dbo].[user_Details] ([id], [FirstName], [LastName], [PhoneNumber], [DateOfBirth], [Address], [City], [Admin], [user_id], [AdditionalAddresses]) VALUES (1, N'Stefan', N'Bisceanu', N'0707073011', CAST(N'2024-05-21' AS Date), N'alabala', N'portocala', 0, 1, N'din frontend|din frontend')
INSERT [dbo].[user_Details] ([id], [FirstName], [LastName], [PhoneNumber], [DateOfBirth], [Address], [City], [Admin], [user_id], [AdditionalAddresses]) VALUES (2, N'string', N'string', N'1234567890', CAST(N'2024-05-21' AS Date), N'string', N'string', 0, 2, NULL)
SET IDENTITY_INSERT [dbo].[user_Details] OFF
GO
SET IDENTITY_INSERT [dbo].[user_Session] ON 

INSERT [dbo].[user_Session] ([Id], [Email], [SessionId], [CreatedAt], [ExpiresAt], [UserID]) VALUES (250, N'stefan@gmail.com', N'4d5cf87c-c639-4255-90cc-c13488298be7', CAST(N'2024-07-04T01:44:07.347' AS DateTime), CAST(N'2024-07-04T02:44:07.347' AS DateTime), 1)
INSERT [dbo].[user_Session] ([Id], [Email], [SessionId], [CreatedAt], [ExpiresAt], [UserID]) VALUES (252, N'stefan@gmail.com', N'154cc9b8-8345-4b2a-885e-7d2da4444356', CAST(N'2024-07-04T02:08:37.097' AS DateTime), CAST(N'2024-07-04T03:08:37.097' AS DateTime), 1)
INSERT [dbo].[user_Session] ([Id], [Email], [SessionId], [CreatedAt], [ExpiresAt], [UserID]) VALUES (253, N'stefan@gmail.com', N'a5225682-a97d-4190-879e-f00c4235e03e', CAST(N'2024-07-04T02:19:56.420' AS DateTime), CAST(N'2024-07-04T03:19:56.420' AS DateTime), 1)
INSERT [dbo].[user_Session] ([Id], [Email], [SessionId], [CreatedAt], [ExpiresAt], [UserID]) VALUES (254, N'stefan@gmail.com', N'5759deb6-6881-4f10-a6b1-b08bb3302807', CAST(N'2024-07-04T02:21:17.393' AS DateTime), CAST(N'2024-07-04T03:21:17.393' AS DateTime), 1)
INSERT [dbo].[user_Session] ([Id], [Email], [SessionId], [CreatedAt], [ExpiresAt], [UserID]) VALUES (255, N'stefan@gmail.com', N'f2375d6a-88f2-40ed-a49b-3e6b626a2213', CAST(N'2024-07-04T02:23:09.863' AS DateTime), CAST(N'2024-07-04T03:23:09.863' AS DateTime), 1)
INSERT [dbo].[user_Session] ([Id], [Email], [SessionId], [CreatedAt], [ExpiresAt], [UserID]) VALUES (256, N'stefan@gmail.com', N'124ceef3-ff79-43ca-8c49-f76ccaf1ce7f', CAST(N'2024-07-04T02:24:14.180' AS DateTime), CAST(N'2024-07-04T03:24:14.180' AS DateTime), 1)
INSERT [dbo].[user_Session] ([Id], [Email], [SessionId], [CreatedAt], [ExpiresAt], [UserID]) VALUES (257, N'stefan@gmail.com', N'ec5ef7d2-ab37-400f-94c6-ce80d8c18794', CAST(N'2024-07-04T02:35:03.437' AS DateTime), CAST(N'2024-07-04T03:35:03.437' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[user_Session] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__user_Cre__A9D10534807D6AB2]    Script Date: 04/07/2024 05:59:50 ******/
ALTER TABLE [dbo].[user_Credentials] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[dishes] ADD  DEFAULT ((0)) FOR [Vegan]
GO
ALTER TABLE [dbo].[user_Details] ADD  DEFAULT ((0)) FOR [Admin]
GO
ALTER TABLE [dbo].[dishes]  WITH CHECK ADD  CONSTRAINT [FK_restaurant_id] FOREIGN KEY([restaurant_id])
REFERENCES [dbo].[restaurants] ([Id])
GO
ALTER TABLE [dbo].[dishes] CHECK CONSTRAINT [FK_restaurant_id]
GO
ALTER TABLE [dbo].[order_dishes]  WITH CHECK ADD  CONSTRAINT [FK_order] FOREIGN KEY([id_order])
REFERENCES [dbo].[orders] ([id])
GO
ALTER TABLE [dbo].[order_dishes] CHECK CONSTRAINT [FK_order]
GO
ALTER TABLE [dbo].[order_dishes]  WITH CHECK ADD  CONSTRAINT [FK_order_dishes] FOREIGN KEY([id_dish])
REFERENCES [dbo].[dishes] ([Id])
GO
ALTER TABLE [dbo].[order_dishes] CHECK CONSTRAINT [FK_order_dishes]
GO
ALTER TABLE [dbo].[user_Details]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[user_Credentials] ([id])
GO
ALTER TABLE [dbo].[user_Session]  WITH CHECK ADD FOREIGN KEY([Email])
REFERENCES [dbo].[user_Credentials] ([Email])
GO
USE [master]
GO
ALTER DATABASE [FoodDelivery] SET  READ_WRITE 
GO
