﻿DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UNITWORDS_DELETE`(IN `P_ID` INT, IN `P_LANGID` INT, IN `P_TEXTBOOKID` INT, IN `P_UNIT` INT, IN `P_PART` INT, IN `P_SEQNUM` INT, IN `P_WORDID` INT, IN `P_WORD` TEXT CHARSET utf8, IN `P_NOTE` TEXT CHARSET utf8, IN `P_FAMIID` INT, IN `P_CORRECT` INT, IN `P_TOTAL` INT)
    MODIFIES SQL DATA
BEGIN
    DECLARE UWCNT INT;
    DECLARE WPCNT INT;
    DECLARE result TEXT;

    DELETE FROM UNITWORDS WHERE ID = P_ID;
    SELECT COUNT(*) INTO UWCNT FROM UNITWORDS WHERE WORDID = P_WORDID;
    SELECT COUNT(*) INTO WPCNT FROM WORDSPHRASES WHERE WORDID = P_WORDID;
    IF UWCNT = 0 AND WPCNT = 0 THEN
        -- exclusive
        DELETE FROM LANGWORDS WHERE ID = P_WORDID;
        DELETE FROM WORDSFAMI WHERE WORDID = P_WORDID;
        SET result = '0';
    ELSE
        -- non-exclusive
        SET result = '1';
    END IF;
    SELECT result;
END$$
DELIMITER ;