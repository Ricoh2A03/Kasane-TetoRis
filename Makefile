ifndef GBDK_HOME
	GBDK_HOME = C:/gbdk/
endif

# Имя конечного ROM-файла
TARGET = bin/game.gbc

# Компилятор и флаги
CC      = $(GBDK_HOME)/bin/lcc
CFLAGS  = -O2 -Wall -autobank #-I$(SRCDIR)/my_libs
ASFLAGS = -O2

# Папки
SRCDIR  = src
OBJDIR  = obj
BINDIR  = bin

# Путь к библиотеке hUGEDriver.lib
# HUGE_DRIVER_LIB = ./lib/hUGEDriver.lib

# Поиск всех C-файлов в папке src и её подпапках
SRC := $(shell find $(SRCDIR) -name '*.c')

# Создание списка объектных файлов в папке obj с сохранением структуры директорий
OBJ := $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(SRC))

# Создание папок, если они не существуют
$(shell mkdir -p $(OBJDIR) $(BINDIR))

.PHONY: all clean

all: $(TARGET)

# Компиляция
$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Линковка
$(TARGET): $(OBJ)
	@echo "Объектные файлы для линковки: $(OBJ)"
	$(CC) $(OBJ) -o $(TARGET) -Wm-yC
	@echo "Сборка завершена: $(TARGET)"


# Очистка
clean:
	rm -rf $(OBJDIR) $(BINDIR)
	@echo "Папки obj и bin очищены."
