USE [PRTEC_DMARTINEZ]
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_USER_RUCD]    Script Date: 16/05/2023 4:20:34 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UPDATE_USER_RUCD]

	@numDocumento varchar(50),
	@Direccion varchar(150),
	@numTelefono varchar(50),
	@correo varchar(50),
	@Municipio int,
	

	-- Parámetros de salida    
    @ERROR_MSG as varchar(MAX) output
AS
BEGIN    
    SET NOCOUNT ON;  
    -- Definición de variables locales   
        SET @ERROR_MSG = ''
    BEGIN TRY
			 IF NOT EXISTS (SELECT 1 FROM Usuario_Rucd WHERE NumeroDocumento = @numDocumento)
				BEGIN
					SET @ERROR_MSG = 'No se puede modificar al usuario por que no se encuentra en el sistema';
				END
			ELSE
				BEGIN
				UPDATE Usuario_Rucd 
							
							SET 
								Direccion = @Direccion,
								Telefono = @numTelefono,
								CorreoElectronico = @correo,
								FK_Municipio = @Municipio
								WHERE NumeroDocumento = @numDocumento;
				END
	END TRY
	BEGIN CATCH
		ROLLBACK;
		SET @ERROR_MSG = ERROR_MESSAGE();
	END CATCH
END

GRANT EXECUTE ON [dbo].[UPDATE_USER_RUCD] TO prtec_dmartinez

select * from Usuario_Rucd

USE [PRTEC_DMARTINEZ]
GO
/****** Object:  StoredProcedure [dbo].[READ_TIPO_DOCUMENTO_RUCD]    Script Date: 16/05/2023 4:20:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[READ_TIPO_DOCUMENTO_RUCD]
    -- Parámetros de salida    
    @ERROR_MSG as varchar(MAX) output
AS
BEGIN    
    SET NOCOUNT ON;  
    -- Definición de variables locales   
        SET @ERROR_MSG = ''
    BEGIN TRY
			
			BEGIN
				Select *
				FROM Tipo_Documento_Rucd
			END
	END TRY
	BEGIN CATCH
		ROLLBACK;
		SET @ERROR_MSG = ERROR_MESSAGE();
	END CATCH
END

GRANT EXECUTE ON [dbo].[READ_TIPO_DOCUMENTO_RUCD] TO prtec_dmartinez

USE [PRTEC_DMARTINEZ]
GO
/****** Object:  StoredProcedure [dbo].[READ_SEXO_RUCD]    Script Date: 16/05/2023 4:20:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[READ_SEXO_RUCD]
    -- Parámetros de salida    
    @ERROR_MSG as varchar(MAX) output
AS
BEGIN    
    SET NOCOUNT ON;  
    -- Definición de variables locales   
        SET @ERROR_MSG = ''
    BEGIN TRY
			BEGIN
				SELECT * FROM Sexo_Rucd;
			END
	END TRY
	BEGIN CATCH
		ROLLBACK;
		SET @ERROR_MSG = ERROR_MESSAGE();
	END CATCH
END

USE [PRTEC_DMARTINEZ]
GO
/****** Object:  StoredProcedure [dbo].[READ_RESIDENCIA_RUCD]    Script Date: 16/05/2023 4:20:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[READ_RESIDENCIA_RUCD]
	@id_dep int,
    -- Parámetros de salida    
    @ERROR_MSG as varchar(MAX) output
AS
BEGIN    
    SET NOCOUNT ON;  
    -- Definición de variables locales   
        SET @ERROR_MSG = ''
    BEGIN TRY
			IF NOT EXISTS (select 1 from Departamento_Rucd dep  
									where dep.ID = @id_dep)
				   BEGIN
						SELECT @ERROR_MSG = 'No se encontró el departamento';
   				   END
			ELSE
			BEGIN
				Select mun.*, dep.Departamento 
				FROM Departamento_Rucd dep JOIN Municipio_Rucd mun
					 ON dep.ID = mun.FK_Dep
				WHERE mun.FK_Dep = @id_dep
			END
	END TRY
	BEGIN CATCH
		ROLLBACK;
		SET @ERROR_MSG = ERROR_MESSAGE();
	END CATCH
END

GRANT EXECUTE ON [dbo].[READ_RESIDENCIA_RUCD] TO prtec_dmartinez

USE [PRTEC_DMARTINEZ]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_USER_RUCD]    Script Date: 16/05/2023 4:20:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[INSERT_USER_RUCD]
    
	@numDocumento varchar(50),
	@PrimerNombre varchar(50),
	@SegundoNombre varchar(50),
	@PrimerApellido varchar(50),
	@SegundoApellido varchar(50),
	@FechaNac date,
	@FecExpDocumento date,
	@Direccion varchar(150),
	@numTelefono varchar(50),
	@NumTelefonoFijo varchar(50),
	@correo varchar(50),
	@Ruta varchar(MAX),
	@TipDoc int,
	@Municipio int,
	@Sexo int,
	@FK_MunNacimiento int,
	@FK_MunExpDoc int,
	@FecRegistro varchar(50),
	-- Parámetros de salida    
    @ERROR_MSG as varchar(MAX) output
AS
BEGIN    
    SET NOCOUNT ON;  
    -- Definición de variables locales   
        SET @ERROR_MSG = ''
    BEGIN TRY
			 IF NOT EXISTS (SELECT 1 FROM Usuario_Rucd WHERE NumeroDocumento = @numDocumento or CorreoElectronico = @Correo)
				BEGIN
					-- Insertar el nuevo registro
					 INSERT INTO Usuario_Rucd (NumeroDocumento,PrimerNombre,SegundoNombre,PrimerApellido,SegundoApellido,FechaNacimiento,Direccion,Telefono,Telefono_Fijo,CorreoElectronico,Ruta,FecRegistro,FecExpDocumento,FK_TipDoc,FK_Municipio,FK_Sexo,FK_MunExpDoc,FK_MunNacimiento)
					 VALUES (@numDocumento, @PrimerNombre,@SegundoNombre,@PrimerApellido,@SegundoApellido,@FechaNac,@Direccion,@numTelefono,@NumTelefonoFijo,@correo ,@Ruta,@FecRegistro,@FecExpDocumento,@TipDoc,@Municipio,@Sexo,@FK_MunExpDoc,@FK_MunNacimiento);
					 SET @ERROR_MSG = 'Registro exitoso.';
				END
			ELSE
				BEGIN
					SET @ERROR_MSG = 'No se pudo crear el usuario, contacte a soporte.';
				END
	END TRY
	BEGIN CATCH
		ROLLBACK;
		SET @ERROR_MSG = ERROR_MESSAGE();
	END CATCH
END

GRANT EXECUTE ON [dbo].[INSERT_USER_RUCD] TO prtec_dmartinez

USE [PRTEC_DMARTINEZ]
GO
/****** Object:  StoredProcedure [dbo].[GET_USER_RUCD]    Script Date: 16/05/2023 4:20:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GET_USER_RUCD]
	@numDocumento varchar(50),
	-- Parámetros de salida    
    @ERROR_MSG as varchar(MAX) output
AS
BEGIN    
    SET NOCOUNT ON;  
    -- Definición de variables locales   
        SET @ERROR_MSG = ''
    BEGIN TRY
			 IF NOT EXISTS (SELECT * FROM Usuario_Rucd WHERE NumeroDocumento = @numDocumento)
				BEGIN
					 SET @ERROR_MSG = 'El documento ingresado no existe en la tabla';
				END
			ELSE
				BEGIN
					SELECT * FROM Usuario_Rucd as usu 
					JOIN Tipo_Documento_Rucd as TipDoc ON usu.FK_TipDoc = TipDoc.ID 
					JOIN Municipio_Rucd as Muni ON usu.FK_Municipio = Muni.ID
					JOIN Sexo_Rucd ON usu.FK_Sexo = Sexo_Rucd.ID 
					JOIN Departamento_Rucd as Dep ON Muni.FK_Dep = Dep.ID
					WHERE NumeroDocumento = @numDocumento
				END
	END TRY
	BEGIN CATCH
		ROLLBACK;
		SET @ERROR_MSG = ERROR_MESSAGE();
	END CATCH
END

USE [PRTEC_DMARTINEZ]
GO
/****** Object:  StoredProcedure [dbo].[DOCUMENT_PATH_RUCD]    Script Date: 16/05/2023 4:20:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[DOCUMENT_PATH_RUCD]
    
	@numDocumento varchar(50),
	
	-- Parámetros de salida    
    @ERROR_MSG  VARCHAR(MAX) output,
	@rutaSalida VARCHAR(MAX) output
AS
BEGIN    
    SET NOCOUNT ON;  
    -- Definición de variables locales   
        SET @ERROR_MSG = ''
    BEGIN TRY
			 IF EXISTS (SELECT 1 FROM Usuario_Rucd WHERE NumeroDocumento = @numDocumento)
				BEGIN 
					
					SET @rutaSalida = (SELECT Usu.Ruta  as ResultadoConsulta 
									   FROM Usuario_Rucd Usu 
										WHERE NumeroDocumento = @numDocumento)
				END
			ELSE
				BEGIN
					SET @ERROR_MSG = 'No se pudo encontrar el documento de identidad';
				END
	END TRY
	BEGIN CATCH
		ROLLBACK;
		SET @ERROR_MSG = ERROR_MESSAGE();
	END CATCH
END

GRANT EXECUTE ON [dbo].[DOCUMENT_PATH_RUCD] TO prtec_dmartinez

USE [PRTEC_DMARTINEZ]
GO
/****** Object:  StoredProcedure [dbo].[ComprobarUsuarioRucd]    Script Date: 16/05/2023 4:18:51 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ComprobarUsuarioRucd]
    
	@numDoc varchar(50),
	@correo_electronico varchar(50),
	
	-- Parámetros de salida    
    @ERROR_MSG as varchar(MAX) output
AS
BEGIN    
    SET NOCOUNT ON;  
    -- Definición de variables locales   
        SET @ERROR_MSG = ''

    BEGIN TRY
		-- Verificar si el usuario ya está registrado en la tabla
		IF EXISTS (SELECT * FROM Usuario_Rucd WHERE NumeroDocumento = @numDoc OR CorreoElectronico = @correo_electronico)
			BEGIN
				SET @ERROR_MSG = 'El usuario ya está registrado en la base de datos.';
			END
		ELSE
			BEGIN
				PRINT 'El usuario no está registrado en la base de datos.';
			END
	END TRY
	BEGIN CATCH
		SET @ERROR_MSG = 'El usuario NO está registrado en la base de datos.';
	END CATCH
END

GRANT EXECUTE ON [dbo].[ComprobarUsuarioRucd] TO prtec_dmartinez