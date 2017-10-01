#include "..\macros.hpp"

#define ONE_ONE_ARRAY [1,1]
#define CHECK_DB_RESULT(res) CHECK_TRUE(count res > 1 && {res select ONE_ONE_ARRAY isEqualTo "1"}, Error in database connection, {diag_log ("Database error: " + str res);false})
