CREATE OR REPLACE FUNCTION dimadev.get_schemas(_schema_name text) 
	RETURNS TABLE(
			table_schema text, 
			table_name text, 
			column_name text, 
			data_type varchar, 
			character_maximum_length int, 
			character_octet_length int
	)
language plpgsql
AS $body$
DECLARE
  _table_list text[];
  _table text;
BEGIN
_table_list := array(select distinct(ist.table_name) from information_schema.tables ist where ist.table_schema = _schema_name);
FOREACH _table IN ARRAY _table_list
	LOOP
		RETURN QUERY EXECUTE
			'SELECT 
			CAST(isc.table_schema AS TEXT), 
			CAST(isc.table_name AS TEXT), 
			CAST(isc.column_name AS TEXT), 
			CAST(isc.data_type AS VARCHAR), 
			CAST(isc.character_maximum_length AS INT), 
			CAST(isc.character_octet_length AS INT) 
		FROM information_schema.columns isc
		WHERE isc.table_schema = $1
		AND isc.table_name = $2'
		USING _schema_name, _table;
	END LOOP;	
END;
$body$;