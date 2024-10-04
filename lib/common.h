#define EXIT_ERROR_MEM -1
#define EXIT_ERROR_FILE_STREAM -2
#define EXIT_ERROR_INVALID_USAGE 1

// Type definitions
typedef char *string;

// Function prototypes
int get_int_input(void);
void get_str_input(string out_str, size_t num);
bool empty_str(const string str);

void *box(size_t size);
void init_zero(void *ptr, size_t size);
