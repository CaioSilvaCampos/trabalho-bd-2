USE [master]
GO
/****** Object:  Database [TapajosLTDA]    Script Date: 22/11/2024 21:39:29 ******/
CREATE DATABASE [TapajosLTDA]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TapajosLTDA', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TapajosLTDA.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TapajosLTDA_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TapajosLTDA_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [TapajosLTDA] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TapajosLTDA].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TapajosLTDA] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TapajosLTDA] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TapajosLTDA] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TapajosLTDA] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TapajosLTDA] SET ARITHABORT OFF 
GO
ALTER DATABASE [TapajosLTDA] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TapajosLTDA] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TapajosLTDA] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TapajosLTDA] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TapajosLTDA] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TapajosLTDA] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TapajosLTDA] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TapajosLTDA] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TapajosLTDA] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TapajosLTDA] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TapajosLTDA] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TapajosLTDA] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TapajosLTDA] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TapajosLTDA] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TapajosLTDA] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TapajosLTDA] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TapajosLTDA] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TapajosLTDA] SET RECOVERY FULL 
GO
ALTER DATABASE [TapajosLTDA] SET  MULTI_USER 
GO
ALTER DATABASE [TapajosLTDA] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TapajosLTDA] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TapajosLTDA] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TapajosLTDA] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TapajosLTDA] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TapajosLTDA] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'TapajosLTDA', N'ON'
GO
ALTER DATABASE [TapajosLTDA] SET QUERY_STORE = ON
GO
ALTER DATABASE [TapajosLTDA] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [TapajosLTDA]
GO
/****** Object:  Table [dbo].[ContasAReceber]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContasAReceber](
	[id_Receber] [int] IDENTITY(1,1) NOT NULL,
	[R_fk_ClienteFornecedor] [int] NOT NULL,
	[R_fk_Lancamento] [int] NULL,
	[R_Valor] [decimal](18, 2) NOT NULL,
	[R_ValorPago] [decimal](18, 2) NULL,
	[R_DataPagamento] [datetime] NULL,
	[R_DataVencimento] [date] NULL,
	[R_Descricao] [varchar](255) NOT NULL,
	[R_fk_banco] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Receber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ContasAReceber]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ContasAReceber] AS
SELECT 
    R_fk_ClienteFornecedor,
    SUM(R_valor) AS total_receber
FROM 
    ContasAReceber
GROUP BY 
    R_fk_ClienteFornecedor;

GO
/****** Object:  Table [dbo].[ContasAPagar]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContasAPagar](
	[id_Pagar] [int] IDENTITY(1,1) NOT NULL,
	[P_fk_ClienteFornecedor] [int] NOT NULL,
	[P_fk_Lancamento] [int] NULL,
	[P_Valor] [decimal](18, 2) NOT NULL,
	[P_ValorPago] [decimal](18, 2) NULL,
	[P_DataVencimento] [datetime] NOT NULL,
	[P_DataPagamento] [datetime] NULL,
	[P_Descricao] [varchar](255) NOT NULL,
	[P_fk_banco] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Pagar] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ContasAPagar]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE VIEW [dbo].[vw_ContasAPagar] AS
SELECT 
    P_fk_ClienteFornecedor,
    SUM(P_valor) AS total_pagar
FROM 
    ContasAPagar
GROUP BY 
    P_fk_ClienteFornecedor;
GO
/****** Object:  View [dbo].[vw_ContasAReceber2]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ContasAReceber2]
AS
SELECT R_fk_ClienteFornecedor, SUM(R_Valor) as totalReceber, R_DataVencimento
FROM ContasAReceber
GROUP BY R_fk_ClienteFornecedor, R_DataVencimento
GO
/****** Object:  View [dbo].[vw_ContasAPagar2]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ContasAPagar2]
AS
SELECT P_fk_ClienteFornecedor, SUM(P_Valor) as totalPagar, P_DataVencimento
FROM ContasAPagar
GROUP BY P_fk_ClienteFornecedor, P_DataVencimento
GO
/****** Object:  Table [dbo].[Bancos]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bancos](
	[id_Banco] [int] IDENTITY(1,1) NOT NULL,
	[fk_Endereco] [int] NULL,
	[Ban_Nome] [varchar](100) NOT NULL,
	[Ban_CNPJ] [varchar](20) NOT NULL,
	[Ban_Saldo] [decimal](18, 2) NOT NULL,
	[Ban_Telefone] [varchar](20) NOT NULL,
	[Ban_Email] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Banco] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientesFornecedores]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientesFornecedores](
	[id_ClienteFornecedor] [int] IDENTITY(1,1) NOT NULL,
	[fk_Endereco] [int] NULL,
	[CF_Nome] [varchar](100) NOT NULL,
	[CF_CPFCNPJ] [varchar](20) NOT NULL,
	[CF_Email] [varchar](100) NOT NULL,
	[CF_Tipo] [varchar](20) NOT NULL,
	[CF_Telefone] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_ClienteFornecedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Enderecos]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enderecos](
	[id_Endereco] [int] IDENTITY(1,1) NOT NULL,
	[EN_CEP] [varchar](20) NOT NULL,
	[EN_Rua] [varchar](100) NOT NULL,
	[EN_Bairro] [varchar](100) NOT NULL,
	[EN_Numero] [int] NOT NULL,
	[EN_Complemento] [varchar](100) NULL,
	[EN_Cidade] [varchar](100) NOT NULL,
	[EN_Estado] [varchar](2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Endereco] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lancamentos]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lancamentos](
	[id_Lancamento] [int] IDENTITY(1,1) NOT NULL,
	[Lan_fk_ClienteFornecedor] [int] NULL,
	[Lan_fk_Banco] [int] NULL,
	[Lan_Tipo] [varchar](20) NOT NULL,
	[Lan_Valor] [decimal](18, 2) NOT NULL,
	[Lan_Data] [datetime] NOT NULL,
	[Lan_Descricao] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Lancamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NF]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NF](
	[id_NF] [int] IDENTITY(1,1) NOT NULL,
	[NF_fk_Receber] [int] NULL,
	[NF_fk_Pagar] [int] NULL,
	[NF_ValorPago] [decimal](18, 2) NOT NULL,
	[NF_Status] [varchar](20) NOT NULL,
	[NF_DataEmissao] [datetime] NOT NULL,
	[NF_Valor] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_NF] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bancos]  WITH CHECK ADD FOREIGN KEY([fk_Endereco])
REFERENCES [dbo].[Enderecos] ([id_Endereco])
GO
ALTER TABLE [dbo].[Bancos]  WITH CHECK ADD FOREIGN KEY([fk_Endereco])
REFERENCES [dbo].[Enderecos] ([id_Endereco])
GO
ALTER TABLE [dbo].[Bancos]  WITH CHECK ADD FOREIGN KEY([fk_Endereco])
REFERENCES [dbo].[Enderecos] ([id_Endereco])
GO
ALTER TABLE [dbo].[ClientesFornecedores]  WITH CHECK ADD FOREIGN KEY([fk_Endereco])
REFERENCES [dbo].[Enderecos] ([id_Endereco])
GO
ALTER TABLE [dbo].[ClientesFornecedores]  WITH CHECK ADD FOREIGN KEY([fk_Endereco])
REFERENCES [dbo].[Enderecos] ([id_Endereco])
GO
ALTER TABLE [dbo].[ClientesFornecedores]  WITH CHECK ADD FOREIGN KEY([fk_Endereco])
REFERENCES [dbo].[Enderecos] ([id_Endereco])
GO
ALTER TABLE [dbo].[ContasAPagar]  WITH CHECK ADD FOREIGN KEY([P_fk_ClienteFornecedor])
REFERENCES [dbo].[ClientesFornecedores] ([id_ClienteFornecedor])
GO
ALTER TABLE [dbo].[ContasAPagar]  WITH CHECK ADD FOREIGN KEY([P_fk_Lancamento])
REFERENCES [dbo].[Lancamentos] ([id_Lancamento])
GO
ALTER TABLE [dbo].[ContasAPagar]  WITH CHECK ADD FOREIGN KEY([P_fk_ClienteFornecedor])
REFERENCES [dbo].[ClientesFornecedores] ([id_ClienteFornecedor])
GO
ALTER TABLE [dbo].[ContasAPagar]  WITH CHECK ADD FOREIGN KEY([P_fk_Lancamento])
REFERENCES [dbo].[Lancamentos] ([id_Lancamento])
GO
ALTER TABLE [dbo].[ContasAPagar]  WITH CHECK ADD FOREIGN KEY([P_fk_ClienteFornecedor])
REFERENCES [dbo].[ClientesFornecedores] ([id_ClienteFornecedor])
GO
ALTER TABLE [dbo].[ContasAPagar]  WITH CHECK ADD FOREIGN KEY([P_fk_Lancamento])
REFERENCES [dbo].[Lancamentos] ([id_Lancamento])
GO
ALTER TABLE [dbo].[ContasAPagar]  WITH CHECK ADD  CONSTRAINT [FK_ContasAPagar_Banco] FOREIGN KEY([P_fk_banco])
REFERENCES [dbo].[Bancos] ([id_Banco])
GO
ALTER TABLE [dbo].[ContasAPagar] CHECK CONSTRAINT [FK_ContasAPagar_Banco]
GO
ALTER TABLE [dbo].[ContasAReceber]  WITH CHECK ADD FOREIGN KEY([R_fk_ClienteFornecedor])
REFERENCES [dbo].[ClientesFornecedores] ([id_ClienteFornecedor])
GO
ALTER TABLE [dbo].[ContasAReceber]  WITH CHECK ADD FOREIGN KEY([R_fk_Lancamento])
REFERENCES [dbo].[Lancamentos] ([id_Lancamento])
GO
ALTER TABLE [dbo].[ContasAReceber]  WITH CHECK ADD FOREIGN KEY([R_fk_ClienteFornecedor])
REFERENCES [dbo].[ClientesFornecedores] ([id_ClienteFornecedor])
GO
ALTER TABLE [dbo].[ContasAReceber]  WITH CHECK ADD FOREIGN KEY([R_fk_Lancamento])
REFERENCES [dbo].[Lancamentos] ([id_Lancamento])
GO
ALTER TABLE [dbo].[ContasAReceber]  WITH CHECK ADD FOREIGN KEY([R_fk_ClienteFornecedor])
REFERENCES [dbo].[ClientesFornecedores] ([id_ClienteFornecedor])
GO
ALTER TABLE [dbo].[ContasAReceber]  WITH CHECK ADD FOREIGN KEY([R_fk_Lancamento])
REFERENCES [dbo].[Lancamentos] ([id_Lancamento])
GO
ALTER TABLE [dbo].[ContasAReceber]  WITH CHECK ADD  CONSTRAINT [FK_ContasAReceber_Banco] FOREIGN KEY([R_fk_banco])
REFERENCES [dbo].[Bancos] ([id_Banco])
GO
ALTER TABLE [dbo].[ContasAReceber] CHECK CONSTRAINT [FK_ContasAReceber_Banco]
GO
ALTER TABLE [dbo].[Lancamentos]  WITH CHECK ADD FOREIGN KEY([Lan_fk_ClienteFornecedor])
REFERENCES [dbo].[ClientesFornecedores] ([id_ClienteFornecedor])
GO
ALTER TABLE [dbo].[Lancamentos]  WITH CHECK ADD FOREIGN KEY([Lan_fk_Banco])
REFERENCES [dbo].[Bancos] ([id_Banco])
GO
ALTER TABLE [dbo].[Lancamentos]  WITH CHECK ADD FOREIGN KEY([Lan_fk_ClienteFornecedor])
REFERENCES [dbo].[ClientesFornecedores] ([id_ClienteFornecedor])
GO
ALTER TABLE [dbo].[Lancamentos]  WITH CHECK ADD FOREIGN KEY([Lan_fk_Banco])
REFERENCES [dbo].[Bancos] ([id_Banco])
GO
ALTER TABLE [dbo].[Lancamentos]  WITH CHECK ADD FOREIGN KEY([Lan_fk_ClienteFornecedor])
REFERENCES [dbo].[ClientesFornecedores] ([id_ClienteFornecedor])
GO
ALTER TABLE [dbo].[Lancamentos]  WITH CHECK ADD FOREIGN KEY([Lan_fk_Banco])
REFERENCES [dbo].[Bancos] ([id_Banco])
GO
ALTER TABLE [dbo].[NF]  WITH CHECK ADD FOREIGN KEY([NF_fk_Pagar])
REFERENCES [dbo].[ContasAPagar] ([id_Pagar])
GO
ALTER TABLE [dbo].[NF]  WITH CHECK ADD FOREIGN KEY([NF_fk_Pagar])
REFERENCES [dbo].[ContasAPagar] ([id_Pagar])
GO
ALTER TABLE [dbo].[NF]  WITH CHECK ADD FOREIGN KEY([NF_fk_Pagar])
REFERENCES [dbo].[ContasAPagar] ([id_Pagar])
GO
ALTER TABLE [dbo].[NF]  WITH CHECK ADD FOREIGN KEY([NF_fk_Receber])
REFERENCES [dbo].[ContasAReceber] ([id_Receber])
GO
ALTER TABLE [dbo].[NF]  WITH CHECK ADD FOREIGN KEY([NF_fk_Receber])
REFERENCES [dbo].[ContasAReceber] ([id_Receber])
GO
ALTER TABLE [dbo].[NF]  WITH CHECK ADD FOREIGN KEY([NF_fk_Receber])
REFERENCES [dbo].[ContasAReceber] ([id_Receber])
GO
ALTER TABLE [dbo].[Bancos]  WITH CHECK ADD  CONSTRAINT [Saldo_Negativo] CHECK  (([Ban_Saldo]>=(0)))
GO
ALTER TABLE [dbo].[Bancos] CHECK CONSTRAINT [Saldo_Negativo]
GO
/****** Object:  StoredProcedure [dbo].[addBanco]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[addBanco] 
	@Ban_Nome VARCHAR(100),
    @Ban_CNPJ VARCHAR(20),
    @Ban_Saldo DECIMAL(18,2),
    @Ban_Telefone VARCHAR(20),
    @Ban_Email VARCHAR(100)
AS
BEGIN
	IF EXISTS (SELECT * FROM Bancos WHERE @Ban_CNPJ = Ban_CNPJ)
		BEGIN
			THROW 50001, 'Já existe um banco com este CNPJ.', 1;
		END

	INSERT INTO Bancos (Ban_Nome, Ban_CNPJ, Ban_Saldo, Ban_Telefone, Ban_Email) 
	VALUES (@Ban_Nome, @Ban_CNPJ, @Ban_Saldo, @Ban_Telefone, @Ban_Email);
	
	PRINT 'Banco adicionado com sucesso';

END
GO
/****** Object:  StoredProcedure [dbo].[addCliente]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[addCliente] 
	 @CF_Nome VARCHAR(100),
     @CF_CPF VARCHAR(20),
     @CF_Email VARCHAR(100), 
     @CF_Telefone VARCHAR(20)
AS
BEGIN
	IF EXISTS (SELECT * FROM ClientesFornecedores WHERE @CF_CPF = CF_CPFCNPJ)
		BEGIN
			THROW 50001, 'Já existe um cliente com este CPF.', 1;
		END

	INSERT INTO ClientesFornecedores(CF_Nome, CF_CPFCNPJ, CF_Email, CF_Tipo, CF_Telefone) 
	VALUES (@CF_Nome, @CF_CPF, @CF_Email, 'Cliente', @CF_Telefone);
	
	PRINT 'Cliente adicionado com sucesso';

END

GO
/****** Object:  StoredProcedure [dbo].[addContaAPagar]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addContaAPagar]
    @P_fk_ClienteFornecedor INT,
    @P_fk_Lancamento INT = NULL,
    @P_Valor DECIMAL(18, 2),
    @P_ValorPago DECIMAL(18, 2) = NULL,
    @P_DataPagamento DATETIME = NULL,
    @P_DataVencimento DATETIME,
    @P_Descricao VARCHAR(255),
	@P_fk_banco INT
AS
BEGIN
	IF NOT EXISTS (Select * from ClientesFornecedores WHERE @P_fk_ClienteFornecedor = id_ClienteFornecedor) 
	BEGIN
		THROW 50001, 'Não existe nenhum cliente ou fornecedor com esse ID', 1;
	END
	IF NOT EXISTS (Select * from Bancos WHERE @P_fk_banco = id_Banco)
	BEGIN
		THROW 50002, 'Nao existe nenhum banco com esse ID', 1
	END
    INSERT INTO ContasAPagar(
        P_fk_ClienteFornecedor,
        P_fk_Lancamento,
        P_Valor,
        P_ValorPago,
        P_DataPagamento,
        P_DataVencimento,
        P_Descricao,
		P_fk_banco
    )
    VALUES (
        @P_fk_ClienteFornecedor,
        @P_fk_Lancamento,
        @P_Valor,
        @P_ValorPago,
        @P_DataPagamento,
        @P_DataVencimento,
        @P_Descricao,
		@P_fk_banco
    );
END;

GO
/****** Object:  StoredProcedure [dbo].[addContaAReceber]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addContaAReceber]
    @R_fk_ClienteFornecedor INT,
    @R_fk_Lancamento INT = NULL,
    @R_Valor DECIMAL(18, 2),
    @R_ValorPago DECIMAL(18, 2) = NULL,
    @R_DataPagamento DATETIME = NULL,
    @R_DataVencimento DATETIME,
    @R_Descricao VARCHAR(255),
	@R_Fk_banco INT
AS
BEGIN
	IF NOT EXISTS (Select * from ClientesFornecedores WHERE @R_fk_ClienteFornecedor = id_ClienteFornecedor) 
	BEGIN
		THROW 50001, 'Não existe nenhum cliente ou fornecedor com esse ID', 1;
	END
	IF NOT EXISTS (Select * from Bancos WHERE @R_fk_banco = id_Banco)
	BEGIN
		THROW 50002, 'Nao existe nenhum banco com esse ID', 1
	END
    INSERT INTO ContasAReceber (
        R_fk_ClienteFornecedor,
        R_fk_Lancamento,
        R_Valor,
        R_ValorPago,
        R_DataPagamento,
        R_DataVencimento,
        R_Descricao,
		R_fk_banco
    )
    VALUES (
        @R_fk_ClienteFornecedor,
        @R_fk_Lancamento,
        @R_Valor,
        @R_ValorPago,
        @R_DataPagamento,
        @R_DataVencimento,
        @R_Descricao,
		@R_Fk_banco
    );
END;


GO
/****** Object:  StoredProcedure [dbo].[addEndereco]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addEndereco]
    @EN_CEP VARCHAR(20),
    @EN_Rua VARCHAR(100),
    @EN_Bairro VARCHAR(100),
    @EN_Numero INT,
    @EN_Complemento VARCHAR(100),
    @EN_Cidade VARCHAR(100),
    @EN_Estado VARCHAR(2) 
AS
BEGIN
		 INSERT INTO Enderecos (EN_CEP, EN_Rua, EN_Bairro, EN_Numero, EN_Complemento, EN_Cidade, EN_Estado)
			VALUES (@EN_CEP, @EN_Rua, @EN_Bairro, @EN_Numero, @EN_Complemento, @EN_Cidade, @EN_Estado);
    
			PRINT 'Endereço inserido com sucesso!';
END;
GO
/****** Object:  StoredProcedure [dbo].[addFornecedor]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[addFornecedor] 
	 @CF_Nome VARCHAR(100),
     @CF_CNPJ VARCHAR(20),
     @CF_Email VARCHAR(100),  
     @CF_Telefone VARCHAR(20)
AS
BEGIN
	IF EXISTS (SELECT * FROM ClientesFornecedores WHERE @CF_CNPJ = CF_CPFCNPJ)
		BEGIN
			THROW 50001, 'Já existe um fornecedor com este CNPJ.', 1;
		END

	INSERT INTO ClientesFornecedores(CF_Nome, CF_CPFCNPJ, CF_Email, CF_Tipo, CF_Telefone) 
	VALUES (@CF_Nome, @CF_CNPJ, @CF_Email,'Fornecedor', @CF_Telefone);
	
	PRINT 'Fornecedor adicionado com sucesso';

END
GO
/****** Object:  StoredProcedure [dbo].[deletarBanco]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[deletarBanco] 
	@CNPJ VARCHAR(20)
AS
BEGIN
	IF EXISTS (SELECT * FROM Bancos WHERE Ban_CNPJ = @CNPJ)
	BEGIN
		DELETE FROM Bancos WHERE Ban_CNPJ = @CNPJ
	END
		ELSE
		BEGIN
        PRINT 'Banco não encontrado.';
    END
END
GO
/****** Object:  StoredProcedure [dbo].[deletarCLIENTEFORN]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[deletarCLIENTEFORN]
 @CPFCNPJ VARCHAR (20)
 AS
 BEGIN
	IF EXISTS (SELECT * FROM ClientesFornecedores WHERE CF_CPFCNPJ = @CPFCNPJ)
		BEGIN
			DELETE FROM ClientesFornecedores WHERE CF_CPFCNPJ = @CPFCNPJ
		END
	ELSE
		BEGIN
        PRINT 'Fornecedor não encontrado.';
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_CaixaDia]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_CaixaDia]
@CPFCNPJ VARCHAR(20),
@DATA DATE
AS
BEGIN
    IF EXISTS(SELECT * FROM ClientesFornecedores WHERE @CPFCNPJ = CF_CPFCNPJ)
    BEGIN
        
        IF EXISTS (
            SELECT *
            FROM ClientesFornecedores CF
            LEFT JOIN vw_ContasAReceber2 AReceber 
                ON CF.id_ClienteFornecedor = AReceber.R_fk_ClienteFornecedor
            LEFT JOIN vw_ContasAPagar2 APagar 
                ON CF.id_ClienteFornecedor = APagar.P_fk_ClienteFornecedor
            WHERE CF.CF_CPFCNPJ = @CPFCNPJ
            AND (AReceber.R_DataVencimento = @DATA OR APagar.P_DataVencimento = @DATA)
        )
        BEGIN
            
            SELECT 
                CF.CF_Nome,
                ISNULL(AReceber.totalReceber, 0) AS Receber,
                ISNULL(APagar.totalPagar, 0) AS Pagar
            FROM 
                ClientesFornecedores CF
            LEFT JOIN 
                vw_ContasAReceber2 AReceber 
                ON CF.id_ClienteFornecedor = AReceber.R_fk_ClienteFornecedor
                AND AReceber.R_DataVencimento = @DATA
            LEFT JOIN 
                vw_ContasAPagar2 APagar 
                ON CF.id_ClienteFornecedor = APagar.P_fk_ClienteFornecedor
                AND APagar.P_DataVencimento = @DATA
            WHERE 
                CF.CF_CPFCNPJ = @CPFCNPJ
        END
        ELSE
        BEGIN
           
            Print 'Não existe nenhum gasto ou recebimento previsto para esta data' 
        END
    END
    ELSE
    BEGIN
        THROW 50001, 'Não existe nenhum usuário com esse CPF ou CNPJ.', 1;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ExtratoBancario]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ExtratoBancario]
    @CNPJ VARCHAR(20)
AS
BEGIN
    IF NOT EXISTS (
        SELECT *
        FROM Bancos
        WHERE Ban_CNPJ = @CNPJ
    )
    BEGIN
        PRINT 'Banco com o CNPJ informado não foi encontrado.';
    END;

    IF NOT EXISTS (
        SELECT *
        FROM Lancamentos L
        INNER JOIN Bancos B ON B.id_Banco = L.Lan_fk_Banco
        WHERE B.Ban_CNPJ = @CNPJ  
    )
    BEGIN
        PRINT 'Não existem lançamentos usando esse banco';
    END;

    
    SELECT 
		Ban_Nome,
        L.Lan_Data AS DataMovimentacao,
        L.Lan_Descricao AS Descricao,
        L.Lan_Tipo AS TipoMovimentacao,
        L.Lan_Valor AS Valor
    FROM Bancos B
    INNER JOIN Lancamentos L ON B.id_Banco = L.Lan_fk_Banco
    WHERE B.Ban_CNPJ = @CNPJ
    ORDER BY L.Lan_Data;
END;


GO
/****** Object:  StoredProcedure [dbo].[sp_ExtratoBancarioPeriodo]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ExtratoBancarioPeriodo]
    @CNPJ VARCHAR(20),
    @DataInicio DATETIME,
    @DataFim DATETIME
AS
BEGIN
    IF NOT EXISTS (
        SELECT *
        FROM Bancos
        WHERE Ban_CNPJ = @CNPJ
    )
    BEGIN
        PRINT 'Banco com o CNPJ informado não foi encontrado.';
        RETURN;
    END;

    IF NOT EXISTS (
        SELECT *
        FROM Lancamentos L
        INNER JOIN Bancos B ON B.id_Banco = L.Lan_fk_Banco
        WHERE B.Ban_CNPJ = @CNPJ
          AND L.Lan_Data BETWEEN @DataInicio AND @DataFim
    )
    BEGIN
        PRINT 'Não há movimentações do banco.';
        RETURN;
    END;

    
    SELECT 
		Ban_Nome,
        L.Lan_Data AS DataMovimentacao,
        L.Lan_Descricao AS Descricao,
        L.Lan_Tipo AS TipoMovimentacao,
        L.Lan_Valor AS Valor
    FROM Bancos B
    INNER JOIN Lancamentos L ON B.id_Banco = L.Lan_fk_Banco
    WHERE B.Ban_CNPJ = @CNPJ
      AND L.Lan_Data BETWEEN @DataInicio AND @DataFim
    ORDER BY L.Lan_Data;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ExtratoCliente]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ExtratoCliente]   
AS
	BEGIN
    SELECT 
        CF.CF_Nome,
        AReceber.total_receber AS receber,
        APagar.total_pagar AS pagar
    FROM 
        ClientesFornecedores CF
    LEFT JOIN 
        vw_ContasAReceber AReceber 
        ON CF.id_ClienteFornecedor = AReceber.R_fk_ClienteFornecedor
    LEFT JOIN 
        vw_ContasAPagar APagar 
        ON CF.id_ClienteFornecedor = APagar.P_fk_ClienteFornecedor
	WHERE CF_Tipo = 'Cliente'
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ExtratoClienteCPF]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ExtratoClienteCPF]
    @CPF VARCHAR(14) 
AS
BEGIN
  IF EXISTS( SELECT * FROM ClientesFornecedores WHERE @CPF = CF_CPFCNPJ)
	BEGIN
    SELECT 
        CF.CF_Nome,
        AReceber.total_receber AS receber,
        APagar.total_pagar AS pagar
    FROM 
        ClientesFornecedores CF
    LEFT JOIN 
        vw_ContasAReceber AReceber 
        ON CF.id_ClienteFornecedor = AReceber.R_fk_ClienteFornecedor
    LEFT JOIN 
        vw_ContasAPagar APagar 
        ON CF.id_ClienteFornecedor = APagar.P_fk_ClienteFornecedor
    WHERE 
        CF.CF_CPFCNPJ = @CPF AND CF.CF_Tipo = 'Cliente'
	END
	ELSE
		THROW 50001, 'Não existe nenhum cliente com esse CPF.', 1;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ExtratoFornecedor]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ExtratoFornecedor]
AS
BEGIN

    SELECT 
        CF.CF_Nome,
        AReceber.total_receber AS receber,
        APagar.total_pagar AS pagar
    FROM 
        ClientesFornecedores CF
    LEFT JOIN 
        vw_ContasAReceber AReceber 
        ON CF.id_ClienteFornecedor = AReceber.R_fk_ClienteFornecedor
    LEFT JOIN 
        vw_ContasAPagar APagar 
        ON CF.id_ClienteFornecedor = APagar.P_fk_ClienteFornecedor
    WHERE 
        CF.CF_Tipo = 'Fornecedor'
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ExtratoFornecedorCNPJ]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ExtratoFornecedorCNPJ]
    @CNPJ VARCHAR(14) 
AS
BEGIN
  IF EXISTS( SELECT * FROM ClientesFornecedores WHERE @CNPJ = CF_CPFCNPJ)
	BEGIN
    SELECT 
        CF.CF_Nome,
        AReceber.total_receber AS receber,
        APagar.total_pagar AS pagar
    FROM 
        ClientesFornecedores CF
    LEFT JOIN 
        vw_ContasAReceber AReceber 
        ON CF.id_ClienteFornecedor = AReceber.R_fk_ClienteFornecedor
    LEFT JOIN 
        vw_ContasAPagar APagar 
        ON CF.id_ClienteFornecedor = APagar.P_fk_ClienteFornecedor
    WHERE 
        CF.CF_CPFCNPJ = @CNPJ AND CF.CF_Tipo = 'Fornecedor'
	END
	ELSE
		THROW 50001, 'Não existe nenhum fornecedor com esse CNPJ.', 1;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_LancamentosClienteFornecedor]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_LancamentosClienteFornecedor]
@CPFCNPJ VARCHAR(14)
AS
BEGIN
	IF EXISTS( SELECT * FROM ClientesFornecedores WHERE @CPFCNPJ = CF_CPFCNPJ)
	BEGIN
    SELECT CF_Nome, Lan_Tipo, Lan_Valor, Lan_Data, Lan_Descricao
	FROM ClientesFornecedores, Lancamentos
	WHERE id_ClienteFornecedor = Lan_fk_ClienteFornecedor AND CF_CPFCNPJ = @CPFCNPJ
	
END
	ELSE 
	THROW 50001, 'Não existe nenhum cliente ou fornecedor com esse CPF/CNPJ.', 1;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SaldoBanco]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SaldoBanco]
AS
BEGIN	
	SELECT Ban_Nome AS Nome , Ban_Saldo As Saldo
	FROM Bancos
END

GO
/****** Object:  StoredProcedure [dbo].[sp_SaldoBancoCNPJ]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SaldoBancoCNPJ]
@CNPJ VARCHAR(14)
AS
BEGIN
	IF EXISTS( SELECT * FROM Bancos WHERE @CNPJ = Ban_CNPJ)
	BEGIN
	SELECT Ban_Nome as Nome, Ban_Saldo as Saldo
	FROM Bancos
	WHERE Ban_CNPJ = @CNPJ
END
	ELSE 
	THROW 50001, 'Não existe nenhum banco com esse CNPJ', 1
END

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateContasAPagar]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateContasAPagar]
    @id_Pagar INT,
    @P_fk_ClienteFornecedor INT = NULL,
    @P_fk_Lancamento INT = NULL,
    @P_Valor DECIMAL(18,2) = NULL,
    @P_ValorPago DECIMAL(18,2) = NULL,
    @P_DataVencimento DATETIME = NULL,
    @P_DataPagamento DATETIME = NULL,
    @P_Descricao VARCHAR(255) = NULL,
    @P_fk_banco INT = NULL
AS
BEGIN
    
    UPDATE ContasAPagar
    SET 
        P_fk_ClienteFornecedor = COALESCE(@P_fk_ClienteFornecedor, P_fk_ClienteFornecedor),
        P_fk_Lancamento = COALESCE(@P_fk_Lancamento, P_fk_Lancamento),
        P_Valor = COALESCE(@P_Valor, P_Valor),
        P_ValorPago = COALESCE(@P_ValorPago, P_ValorPago),
        P_DataVencimento = COALESCE(@P_DataVencimento, P_DataVencimento),
        P_DataPagamento = COALESCE(@P_DataPagamento, P_DataPagamento),
        P_Descricao = COALESCE(@P_Descricao, P_Descricao),
        P_fk_banco = COALESCE(@P_fk_banco, P_fk_banco)
    WHERE id_Pagar = @id_Pagar;

    PRINT 'Registro atualizado com sucesso!';
END;


GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateContasAReceber]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateContasAReceber]
    @id_Receber INT,
    @R_fk_ClienteFornecedor INT = NULL,
    @R_fk_Lancamento INT = NULL,
    @R_Valor DECIMAL(18,2) = NULL,
    @R_ValorPago DECIMAL(18,2) = NULL,
    @R_DataVencimento DATETIME = NULL,
    @R_DataPagamento DATETIME = NULL,
    @R_Descricao VARCHAR(255) = NULL,
    @R_fk_banco INT = NULL
AS
BEGIN
    -- Atualiza a tabela ContasAReceber com base nos parâmetros fornecidos
    UPDATE ContasAReceber
    SET 
        R_fk_ClienteFornecedor = COALESCE(@R_fk_ClienteFornecedor, R_fk_ClienteFornecedor),
        R_fk_Lancamento = COALESCE(@R_fk_Lancamento, R_fk_Lancamento),
        R_Valor = COALESCE(@R_Valor, R_Valor),
        R_ValorPago = COALESCE(@R_ValorPago, R_ValorPago),
        R_DataVencimento = COALESCE(@R_DataVencimento, R_DataVencimento),
        R_DataPagamento = COALESCE(@R_DataPagamento, R_DataPagamento),
        R_Descricao = COALESCE(@R_Descricao, R_Descricao),
        R_fk_banco = COALESCE(@R_fk_banco, R_fk_banco)
    WHERE id_Receber = @id_Receber;

    -- Retorna mensagem de sucesso
    PRINT 'Registro atualizado com sucesso!';
END;
GO
/****** Object:  StoredProcedure [dbo].[updateClienteFornecedor]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[updateClienteFornecedor]
	@fk_Endereco INT,
    @CF_Nome VARCHAR(100),
    @CF_CPFCNPJ VARCHAR(20),
    @CF_Email VARCHAR(100),
    @CF_Tipo VARCHAR(20),
    @CF_Telefone VARCHAR(20)

AS
BEGIN
	IF NOT EXISTS (SELECT * FROM ClientesFornecedores WHERE @CF_CPFCNPJ = CF_CPFCNPJ)
	
	BEGIN
			THROW 50001, 'Esse cliente/fornecedor nao existe!', 1;
	END
	UPDATE ClientesFornecedores
	SET fk_Endereco = @fk_Endereco,
        CF_Nome = @CF_Nome,
        CF_CPFCNPJ = @CF_CPFCNPJ,
        CF_Email = @CF_Email,
        CF_Tipo = @CF_Tipo,
        CF_Telefone = @CF_Telefone
	WHERE @CF_CPFCNPJ = CF_CPFCNPJ

	PRINT 'Cliente/Fornecedor alterado com sucesso!';
END

GO
/****** Object:  Trigger [dbo].[trg_GerarNFPagar]    Script Date: 22/11/2024 21:39:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_GerarNFPagar]
ON [dbo].[ContasAPagar]
FOR INSERT 
AS
BEGIN
	INSERT INTO NF (NF_fk_Pagar, NF_ValorPago, NF_Status, NF_DataEmissao, NF_Valor) 
	SELECT i.id_Pagar, i.P_ValorPago, 'Pago', i.P_DataPagamento, i.P_Valor 
	FROM inserted i
	WHERE i.P_ValorPago IS NOT NULL AND i.P_DataPagamento IS NOT NULL;
	
END
GO
ALTER TABLE [dbo].[ContasAPagar] ENABLE TRIGGER [trg_GerarNFPagar]
GO
/****** Object:  Trigger [dbo].[trg_LancamentoPagar]    Script Date: 22/11/2024 21:39:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[trg_LancamentoPagar]
ON [dbo].[ContasAPagar]
FOR INSERT
AS
BEGIN
    INSERT INTO Lancamentos (Lan_fk_ClienteFornecedor, Lan_fk_Banco, Lan_Valor, Lan_Descricao, Lan_Data, Lan_Tipo)
    SELECT i.P_fk_ClienteFornecedor, i.P_fk_banco, i.P_ValorPago, i.P_Descricao, i.P_DataPagamento, 'Transferência'
    FROM inserted i
    WHERE i.P_ValorPago IS NOT NULL AND i.P_DataPagamento IS NOT NULL;
END;
GO
ALTER TABLE [dbo].[ContasAPagar] ENABLE TRIGGER [trg_LancamentoPagar]
GO
/****** Object:  Trigger [dbo].[trgGerarNFReceber]    Script Date: 22/11/2024 21:39:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trgGerarNFReceber]
ON [dbo].[ContasAReceber]
FOR INSERT 
AS
BEGIN
	INSERT INTO NF (NF_fk_Receber, NF_ValorPago, NF_Status, NF_DataEmissao, NF_Valor) 
	SELECT i.id_Receber, i.R_ValorPago, 'Recebido', i.R_DataPagamento, i.R_Valor 
	FROM inserted i
	WHERE i.R_ValorPago IS NOT NULL AND i.R_DataPagamento IS NOT NULL;
	
END
GO
ALTER TABLE [dbo].[ContasAReceber] ENABLE TRIGGER [trgGerarNFReceber]
GO
/****** Object:  Trigger [dbo].[trgLancamentoReceber]    Script Date: 22/11/2024 21:39:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trgLancamentoReceber]
ON [dbo].[ContasAReceber]
FOR INSERT
AS
BEGIN
    INSERT INTO Lancamentos (Lan_fk_ClienteFornecedor, Lan_fk_Banco, Lan_Valor, Lan_Descricao, Lan_Data, Lan_Tipo)
    SELECT i.R_fk_ClienteFornecedor, i.R_fk_banco, i.R_ValorPago, i.R_Descricao, i.R_DataPagamento, 'Recebimento'
    FROM inserted i
    WHERE i.R_ValorPago IS NOT NULL AND i.R_DataPagamento IS NOT NULL;
END;

GO
ALTER TABLE [dbo].[ContasAReceber] ENABLE TRIGGER [trgLancamentoReceber]
GO
/****** Object:  Trigger [dbo].[trg_addFkLancamento]    Script Date: 22/11/2024 21:39:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_addFkLancamento]
ON [dbo].[Lancamentos]
FOR INSERT 
AS 
BEGIN
	 UPDATE ContasAPagar
		SET P_fk_Lancamento = i.id_Lancamento
	 FROM inserted i
	 WHERE ContasAPagar.P_DataPagamento = i.Lan_Data 
	 AND ContasAPagar.P_Descricao = i.Lan_Descricao
	 AND ContasAPagar.P_ValorPago = i.Lan_Valor
	 AND i.Lan_Tipo = 'Transferência'

	 
END;
GO
ALTER TABLE [dbo].[Lancamentos] ENABLE TRIGGER [trg_addFkLancamento]
GO
/****** Object:  Trigger [dbo].[trg_addFkLancamento2]    Script Date: 22/11/2024 21:39:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_addFkLancamento2]
ON [dbo].[Lancamentos]
FOR INSERT 
AS 
BEGIN
	 UPDATE ContasAReceber
		SET R_fk_Lancamento = i.id_Lancamento
	 FROM inserted i
	 WHERE R_DataPagamento = i.Lan_Data 
	   AND R_Descricao = i.Lan_Descricao
	   AND R_Valor = i.Lan_Valor
	   AND i.Lan_Tipo = 'Recebimento'
END;


GO
ALTER TABLE [dbo].[Lancamentos] ENABLE TRIGGER [trg_addFkLancamento2]
GO
/****** Object:  Trigger [dbo].[trg_AtualizaSaldoBanco]    Script Date: 22/11/2024 21:39:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_AtualizaSaldoBanco]
ON [dbo].[Lancamentos]
FOR INSERT
AS
BEGIN
    UPDATE Bancos
    SET Ban_Saldo = Ban_Saldo - i.Lan_Valor
    FROM inserted i
    WHERE Bancos.id_Banco = i.Lan_fk_Banco AND i.Lan_Tipo = 'Transferência';
END;
GO
ALTER TABLE [dbo].[Lancamentos] ENABLE TRIGGER [trg_AtualizaSaldoBanco]
GO
/****** Object:  Trigger [dbo].[trg_AumentaSaldoBanco]    Script Date: 22/11/2024 21:39:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_AumentaSaldoBanco]
ON [dbo].[Lancamentos]
FOR INSERT
AS
BEGIN
    UPDATE Bancos
    SET Ban_Saldo = Ban_Saldo + i.Lan_Valor
    FROM inserted i
    WHERE Bancos.id_Banco = i.Lan_fk_Banco AND i.Lan_Tipo = 'Recebimento';
END;
GO
ALTER TABLE [dbo].[Lancamentos] ENABLE TRIGGER [trg_AumentaSaldoBanco]
GO
USE [master]
GO
ALTER DATABASE [TapajosLTDA] SET  READ_WRITE 
GO
