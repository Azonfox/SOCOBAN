--[[ Мои старые нстройки
function love.conf(c)
  c.title = "Socoban"
  local window = c.screen or c.window -- love 0.9 renamed "screen" to "window"
  c.window.usedpiscale=true  -- noFULL screen
  --c.window.width = 896+32 --640
  --c.window.height = 512
end
--]] 

-- Настройки расширенные
gw = 800 --896+32   -- Базовое разрешение
gh = 512  
---sx = 1        -- Базовый масштаб
---sy = 1 
 
function love.conf(t) 
    t.identity = nil                   -- Имя папки сохранения (строка) 
    --t.version = "0.10.2"                -- Версия LOVE, для которой сделана эта игра (строка) 
    t.console = false                  -- Подключение консоли (boolean, только в Windows) 
  t.window.usedpiscale=true      -- FULL screen
    t.window.title = "Socoban"         -- Заголовок окна (строка) 
    t.window.icon = "icon.png"         -- Путь к файлу изображения, используемого как значок окна (строка) или --nil
    t.window.width = gw                 -- Ширина окна (число) 
    t.window.height = gh                -- Высота окна (число) 
    t.window.borderless = false        -- Удаление всего визуального оформления границ окна (boolean) 
    t.window.resizable = true          -- Разрешаем пользователю изменять размер окна (boolean) 
    t.window.minwidth = 1              -- Минимальная ширина окна при возможности его изменения (число) 
    t.window.minheight = 1             -- Минимальная высота окна при возможности его изменения (число) 
    t.window.fullscreen = false        -- Включение полноэкранного режима (boolean)     
   -- t.window.fullscreentype = "exclusive" -- Стандартный полный экран или режим рабочего стола для полного экрана (строка) 
    t.window.vsync = true              -- Включение вертикальной синхронизации (boolean) 
    t.window.fsaa = 0                  -- Число сэмплов при мультисэмпловом антиалиасинге  (число) 
    t.window.display = 1               -- Индекс монитора, в котором должно отображаться окно (число) 
    t.window.highdpi = false           -- Включение режима высокого dpi для окна на дисплее Retina (boolean) 
    t.window.srgb = false              -- Включение гамма-коррекции sRGB при отрисовке на экране (boolean) 
    t.window.x = nil                   -- Координата x позиции окна на указанном дисплее (число) 
    t.window.y = nil                   -- Координата y позиции окна на указанном дисплее (число) 
   -- Подключение модулей
    t.modules.audio = true      -- Включение аудиомодуля (boolean) 
    t.modules.event = true      -- Включение модуля событий (boolean) 
    t.modules.graphics = true   -- Включение модуля графики (boolean) 
    t.modules.image = true      -- Включение модуля изображений (boolean) 
    t.modules.joystick = true   -- Включение модуля джойстика (boolean) 
    t.modules.keyboard = true   -- Включение модуля клавиатуры (boolean) 
    t.modules.math = true       -- Включение модуля математики (boolean) 
    t.modules.mouse = true      -- Включение модуля мыши (boolean) 
    t.modules.physics = true    -- Включение модуля физики (boolean) 
    t.modules.sound = true      -- Включение модуля звука (boolean) 
    t.modules.system = true     -- Включение модуля системы (boolean) 
    t.modules.timer = true      -- Включение модуля таймера (boolean), при его отключении 0 delta time в love.update будет иметь значение 0 
    t.modules.window = true     -- Включение модуля окон (boolean) 
    t.modules.thread = true     -- Включение модуля потоков (boolean) 
end 
 