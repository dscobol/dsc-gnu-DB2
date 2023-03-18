# Note: Bind File

This is an example prep and bind file for 
the pre-compile process for GnuCOBOL/DB2.

```
connect to DB user userid using password;
prep ../cbl/DBCBEX01.sqb bindfile target ANSI_COBOL output ../tcbl/DBCBEX01.cbl;
bind ../cbl/DBCBEX01.bnd;
connect reset;
```

To Use:
You would need to update DB, userid and password to the correct parameters.

If your database was "SRV", your userid was "mary" and your password was "hadalittlelamb" the connect line would look like:
(Note: the password IS case-sensitive!)
```
connect to SRV user mary using hadalittlelamb;
```
You would also change all the references to the program you are prep/binding to.
