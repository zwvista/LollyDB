﻿DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `LANGPHRASES_DELETE`(IN `P_ID` INT, IN `P_LANGID` INT, IN `P_PHRASE` TEXT CHARSET utf8, IN `P_TRANSLATION` TEXT CHARSET utf8)
    MODIFIES SQL DATA
BEGIN
    DELETE FROM LANGPHRASES WHERE ID = P_ID;
    DELETE FROM UNITPHRASES WHERE PHRASEID = P_ID;
    DELETE FROM PATTERNSPHRASES WHERE PHRASEID = P_ID;
    DELETE FROM WORDSPHRASES WHERE PHRASEID = P_ID;
    SELECT '0' AS result;
END$$
DELIMITER ;