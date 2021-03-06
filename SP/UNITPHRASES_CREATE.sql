﻿DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UNITPHRASES_CREATE`(IN `P_ID` INT, IN `P_LANGID` INT, IN `P_TEXTBOOKID` INT, IN `P_UNIT` INT, IN `P_PART` INT, IN `P_SEQNUM` INT, IN `P_PHRASEID` INT, IN `P_PHRASE` TEXT CHARSET utf8, IN `P_TRANSLATION` TEXT CHARSET utf8)
    MODIFIES SQL DATA
BEGIN
    DECLARE result TEXT;
    DECLARE LPCNT INT;
    DECLARE NEW_PHRASEID INT;

    SELECT COUNT(*) INTO LPCNT FROM LANGPHRASES WHERE LANGID = P_LANGID AND CAST(PHRASE AS CHAR CHARSET BINARY) = CAST(P_PHRASE AS CHAR CHARSET BINARY);
    IF LPCNT = 0 THEN
        -- new phrase
        INSERT LANGPHRASES (LANGID, PHRASE, TRANSLATION) VALUES (P_LANGID, P_PHRASE, P_TRANSLATION);
        SELECT LAST_INSERT_ID() INTO NEW_PHRASEID;
        SET result = '0';
    ELSE
        -- existing phrase
        SELECT ID INTO NEW_PHRASEID FROM LANGPHRASES WHERE LANGID = P_LANGID AND CAST(PHRASE AS CHAR CHARSET BINARY) = CAST(P_PHRASE AS CHAR CHARSET BINARY) LIMIT 1;
        SET result = '1';
    END IF;
    INSERT UNITPHRASES (TEXTBOOKID, UNIT, PART, SEQNUM, PHRASEID) VALUES (P_TEXTBOOKID, P_UNIT, P_PART, P_SEQNUM, NEW_PHRASEID);
    SELECT LAST_INSERT_ID() AS NEW_ID, result;
END$$
DELIMITER ;