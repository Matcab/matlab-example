@ECHO OFF

REM ==============================================================================
REM   FILENAME      : lance_template-matlab.bat
REM   BIBLIOGRAPHY  : NEANT
REM   VERSION 		  : 3.0
REM   RENAULT TRUCKS 2014
REM   LOCALISATION  : X:\template-matlab-v3.0\bin
REM   ABSTRACT 		  : Stand alone TEMPLATE-MATLAB Launching file
REM ==============================================================================
REM   PARAMETERS    : NEANT
REM   ALGORITHM     :
REM    	Environment variable initialisation
REM    	Executable file of the application launching
REM ==============================================================================
REM   HISTORY :
REM   AUTHOR                      		DATE         	COMMENTS
REM 	M.CAZENAVE                      20-Jun-2010     Update to 2.0
REM  	M.CABANES                       19-Jun-2014     Update to 3.0
REM ==============================================================================
REM --------------------
REM Software environment
REM --------------------

REM Software version and directory (Mandatory)
REM ------------------------------------------
SET TEMPLATE_VERSION=%2%
SET TEMPLATE_HOME=%1%

REM External library directory (Optional)
REM -------------------------------------
REM BIBMTLB_VERSION=1.1
REM BIBMTLB_HOME=%TEMPLATE_HOME%\lib\bibmtlb-%BIBMTLB_VERSION%

REM User directory (Mandatory)
REM --------------------------
SET TEMPLATE_USER_DIRECTORY=C:\mt_user

REM Common directory (Optional)
REM ---------------------------
REM TEMPLATE_COMMON_DATA=T:\template-matlab

REM -------------------
REM Software parameters
REM -------------------

REM Software guide (Mandatory)
REM --------------------------
REM TEMPLATE_USER_GUIDE=template-matlab_ug_1.0.pdf
REM TEMPLATE_TECHNICAL_GUIDE=template-matlab_tg_1.0.pdf
SET TEMPLATE_SG_PART1=MATLAB_Standard-guidelines_Part_1_Programing_Style_v2.0.pdf

REM Error management (Mandatory)
REM ----------------------------
SET ERR_LOGFILE=%TEMPLATE_USER_DIRECTORY%\error\mt_error.log
SET DEVELOPER_MAIL=mathieu.cabanes@consultant.volvo.com

REM -----------------------
REM Running the application
REM -----------------------

REM Changing directory
REM ------------------
CD %TEMPLATE_HOME%\bin\win32

ECHO. ___________________________
ECHO.
ECHO.     TEMPLATE-MATLAB %TEMPLATE_VERSION%
ECHO.        2014/06/23 - VOLVO
ECHO. ___________________________
ECHO.

REM Executable name building
REM ------------------------
SET EXE_NAME=mt%TEMPLATE_VERSION%_win

REM Delete dot inside the executable name
REM -------------------------------------
SET EXE_NAME=%EXE_NAME:.=%

REM Starting
REM --------
%EXE_NAME%