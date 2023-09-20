// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(url) =>
      "Халдея — кроссплатформенная утилита для Fate/GO. Поддержка просмотра игровых данных, планирования слуг/событий/предметов, планирования основных миссий, симулятор призыва и т. д. Подробности: ${url}";

  static String m15(count) => "Зарядить NP до ${count}";

  static String m1(version) => "Требуемая версия приложения: ≥ ${version}";

  static String m4(error) => "Импорт не удался. Ошибка:\n${error}";

  static String m9(region) => "${region} Уведомление";

  static String m12(n) => "Профиль ${n}";

  static String m29(pause, remain) => "Надо подождать ${pause} секунд между загрузками (${remain}остаются).";

  static String m13(a, b) => "${a} ${b}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about_app": MessageLookupByLibrary.simpleMessage("О нас"),
        "about_app_declaration_text": MessageLookupByLibrary.simpleMessage(
            "Данные, используемые в этом приложении, получены из игры Fate/GO и следующих сайтов. Авторские права на оригинальные тексты, картинки и голоса из игры принадлежат TYPE MOON/FGO PROJECT. Дизайн программы основан на мини-программе WeChat \"Material Programe\". и iOS-приложение \"Guda\". Боевой симулятор \"Лаплас\" реализован Yome - автором \"FGO Simulator\". - которая также вдохновлена командой FGO."),
        "about_data_source": MessageLookupByLibrary.simpleMessage("Источник данных"),
        "about_data_source_footer": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, сообщите нам, если есть неотмеченный источник или нарушение авторских прав."),
        "about_feedback": MessageLookupByLibrary.simpleMessage("Feedback"),
        "account_title": MessageLookupByLibrary.simpleMessage("Аккаунт"),
        "add": MessageLookupByLibrary.simpleMessage("Добавить"),
        "add_feedback_details_warning":
            MessageLookupByLibrary.simpleMessage("Пожалуйста, добавьте детали обратной связи"),
        "add_mission": MessageLookupByLibrary.simpleMessage("Добавить Миссию"),
        "add_to_blacklist": MessageLookupByLibrary.simpleMessage("Добавить в черный список"),
        "app_data_folder": MessageLookupByLibrary.simpleMessage("Папка с данными"),
        "app_data_use_external_storage":
            MessageLookupByLibrary.simpleMessage("Использовать внешнее хранилище (SD-карту)"),
        "april_fool": MessageLookupByLibrary.simpleMessage("Первое Апреля"),
        "ascension": MessageLookupByLibrary.simpleMessage("Вознесение"),
        "ascension_short": MessageLookupByLibrary.simpleMessage("Вознес"),
        "ascension_stage": MessageLookupByLibrary.simpleMessage("Этап Вознесение"),
        "ascension_stage_short": MessageLookupByLibrary.simpleMessage("Этап"),
        "ascension_up": MessageLookupByLibrary.simpleMessage("Вознесение"),
        "atlas_load": MessageLookupByLibrary.simpleMessage("Загрузка"),
        "attach_from_files": MessageLookupByLibrary.simpleMessage("Из Файлов"),
        "attach_from_photos": MessageLookupByLibrary.simpleMessage("Из Фото"),
        "attach_help": MessageLookupByLibrary.simpleMessage(
            "Если возникли проблемы с выбором изображений, используйте вместо них файлы"),
        "auth_data_hints": MessageLookupByLibrary.simpleMessage(
            "Пункты: - userId здесь не является кодом друга, который вы видели на странице входа / друга - НЕ передавайте указанные ключи или скриншоты другим лицам!!! - выберите один из следующих методов импорта"),
        "auto_reset": MessageLookupByLibrary.simpleMessage("Автосброс"),
        "auto_update": MessageLookupByLibrary.simpleMessage("Автообновление"),
        "autoplay": MessageLookupByLibrary.simpleMessage("Автозапуск"),
        "background": MessageLookupByLibrary.simpleMessage("Фон"),
        "backup": MessageLookupByLibrary.simpleMessage("Резервная копия"),
        "backup_failed": MessageLookupByLibrary.simpleMessage("Сбой копирования"),
        "backup_history": MessageLookupByLibrary.simpleMessage("Копировать Историю"),
        "battle_attack": MessageLookupByLibrary.simpleMessage("Атака"),
        "battle_buff_permanent": MessageLookupByLibrary.simpleMessage("Постоянно"),
        "battle_change_ascension": MessageLookupByLibrary.simpleMessage("Изменить Вознесение"),
        "battle_click_to_select_servants": MessageLookupByLibrary.simpleMessage("Нажмите чтобы выбрать Слугу"),
        "battle_damage": MessageLookupByLibrary.simpleMessage("Урон"),
        "battle_damage_parameters": MessageLookupByLibrary.simpleMessage("Параметры Урона"),
        "battle_damage_rate": MessageLookupByLibrary.simpleMessage("Уровень Урона"),
        "battle_no_quest_phase": MessageLookupByLibrary.simpleMessage("Фаза квеста не выбрана."),
        "battle_no_servant": MessageLookupByLibrary.simpleMessage("Слуга не выбран."),
        "battle_no_skill_selected": MessageLookupByLibrary.simpleMessage("Навык не выбран"),
        "battle_quest_from": MessageLookupByLibrary.simpleMessage("Из"),
        "battle_random": MessageLookupByLibrary.simpleMessage("Рандома"),
        "battle_records": MessageLookupByLibrary.simpleMessage("Записи"),
        "battle_simulation": MessageLookupByLibrary.simpleMessage("Симуляция Битвы"),
        "battle_simulation_setup": MessageLookupByLibrary.simpleMessage("Настройка Команды"),
        "battle_skip_current_wave": MessageLookupByLibrary.simpleMessage("Пропустить текущий этап"),
        "battle_targeted_required_hint":
            MessageLookupByLibrary.simpleMessage("Сначала убедитесь, что враг/союзник правильно нацелился."),
        "battle_turn": MessageLookupByLibrary.simpleMessage("Ход"),
        "battle_turn_end": MessageLookupByLibrary.simpleMessage("Конец Хода"),
        "blacklist": MessageLookupByLibrary.simpleMessage("Черный список"),
        "branch_quest": MessageLookupByLibrary.simpleMessage("Ветка Квеста"),
        "bronze": MessageLookupByLibrary.simpleMessage("Бронза"),
        "buff_check_opponent": MessageLookupByLibrary.simpleMessage("Оппонент"),
        "calculate": MessageLookupByLibrary.simpleMessage("Вычислить"),
        "cancel": MessageLookupByLibrary.simpleMessage("Закрыть"),
        "card_asset_status": MessageLookupByLibrary.simpleMessage("Значок Статуса"),
        "card_collection_status": MessageLookupByLibrary.simpleMessage("Статус"),
        "card_description": MessageLookupByLibrary.simpleMessage("Описание"),
        "card_info": MessageLookupByLibrary.simpleMessage("Инфо"),
        "chaldea_gate": MessageLookupByLibrary.simpleMessage("Шлюз Chaldea"),
        "chaldea_server": MessageLookupByLibrary.simpleMessage("Сервер Chaldea"),
        "chaldea_server_cn": MessageLookupByLibrary.simpleMessage("Китай"),
        "chaldea_server_global": MessageLookupByLibrary.simpleMessage("Глобально"),
        "chaldea_share_msg": m0,
        "change_log": MessageLookupByLibrary.simpleMessage("Изменить Лог"),
        "characters_in_card": MessageLookupByLibrary.simpleMessage("Персонажи"),
        "charge_np_to": m15,
        "check_file_hash": MessageLookupByLibrary.simpleMessage("Проверка целостности файлов"),
        "check_update": MessageLookupByLibrary.simpleMessage("Проверка обновления"),
        "clear": MessageLookupByLibrary.simpleMessage("Очистить"),
        "clear_cache": MessageLookupByLibrary.simpleMessage("Очистить Кэш"),
        "clear_cache_finish": MessageLookupByLibrary.simpleMessage("Кэш очищен"),
        "clear_cache_hint": MessageLookupByLibrary.simpleMessage("Включая иллюстрации, голоса"),
        "clear_data": MessageLookupByLibrary.simpleMessage("Очистить Данные"),
        "common_release_group_hint":
            MessageLookupByLibrary.simpleMessage("Необходимо выполнить только одну *Группу* условий"),
        "confirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
        "contact_information_not_filled": MessageLookupByLibrary.simpleMessage("Контактная информация не заполнена"),
        "copied": MessageLookupByLibrary.simpleMessage("Скопировано"),
        "copy": MessageLookupByLibrary.simpleMessage("Копировать"),
        "copy_plan_menu": MessageLookupByLibrary.simpleMessage("Копировать План из..."),
        "cost": MessageLookupByLibrary.simpleMessage("Цена"),
        "costume": MessageLookupByLibrary.simpleMessage("Костюм"),
        "costume_unlock": MessageLookupByLibrary.simpleMessage("Костюм Разблокирован"),
        "create_account_textfield_helper":
            MessageLookupByLibrary.simpleMessage("Вы можете добавить больше аккаунтов позже в Настройках"),
        "create_duplicated_svt": MessageLookupByLibrary.simpleMessage("Создать дубликат"),
        "cur_account": MessageLookupByLibrary.simpleMessage("Текущий Аккаунт"),
        "current_version": MessageLookupByLibrary.simpleMessage("Текущая версия"),
        "custom_mission": MessageLookupByLibrary.simpleMessage("Пользовательская Миссия"),
        "custom_mission_nothing_hint":
            MessageLookupByLibrary.simpleMessage("Нет миссии, нажмите +, чтобы добавить миссию"),
        "custom_mission_source_mission": MessageLookupByLibrary.simpleMessage("Оригинальная Миссия"),
        "custom_skill": MessageLookupByLibrary.simpleMessage("Пользовательский Навык"),
        "daily_training_quest": MessageLookupByLibrary.simpleMessage("Тренировочная Площадка"),
        "damage": MessageLookupByLibrary.simpleMessage("Урон"),
        "damage_recorder_param_hint": MessageLookupByLibrary.simpleMessage("Нажмите для показа вычисленных параметров"),
        "dark_mode": MessageLookupByLibrary.simpleMessage("Темный режим"),
        "dark_mode_dark": MessageLookupByLibrary.simpleMessage("Темная"),
        "dark_mode_light": MessageLookupByLibrary.simpleMessage("Светлая"),
        "dark_mode_system": MessageLookupByLibrary.simpleMessage("Система"),
        "database": MessageLookupByLibrary.simpleMessage("База данных"),
        "database_not_downloaded": MessageLookupByLibrary.simpleMessage("База данных не загружена, продолжить?"),
        "dataset_version": MessageLookupByLibrary.simpleMessage("Версия Базы данных"),
        "date": MessageLookupByLibrary.simpleMessage("Дата"),
        "death_chance": MessageLookupByLibrary.simpleMessage("Шанс Смерти"),
        "debug": MessageLookupByLibrary.simpleMessage("Debug"),
        "debug_fab": MessageLookupByLibrary.simpleMessage("Debug FAB"),
        "debug_menu": MessageLookupByLibrary.simpleMessage("Debug Меню"),
        "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
        "delete_reason": MessageLookupByLibrary.simpleMessage("Причина удаления"),
        "demands": MessageLookupByLibrary.simpleMessage("Требования"),
        "describe_mission": MessageLookupByLibrary.simpleMessage("Опишите Миссию"),
        "desktop_only": MessageLookupByLibrary.simpleMessage("Только ПК"),
        "details": MessageLookupByLibrary.simpleMessage("Подробности"),
        "disable": MessageLookupByLibrary.simpleMessage("Отключить"),
        "done": MessageLookupByLibrary.simpleMessage("ГОТОВО"),
        "download": MessageLookupByLibrary.simpleMessage("Скачать"),
        "download_latest_gamedata_hint": MessageLookupByLibrary.simpleMessage(
            "Чтобы обеспечить совместимость, перед обновлением обновите приложение до последней версии."),
        "download_source": MessageLookupByLibrary.simpleMessage("Скачать исходный код"),
        "download_source_hint": MessageLookupByLibrary.simpleMessage("Конечная точка CN для материкового Китая"),
        "downloaded": MessageLookupByLibrary.simpleMessage("Загружено"),
        "downloading": MessageLookupByLibrary.simpleMessage("Загрузка"),
        "drop_calc_solve": MessageLookupByLibrary.simpleMessage("Решить"),
        "drop_from_all_hashes_hint": MessageLookupByLibrary.simpleMessage(
            "Квестовые враги показаны только для текущей версии, но данные о выпадении собираются со всех версий"),
        "edit": MessageLookupByLibrary.simpleMessage("Изменить"),
        "efficiency": MessageLookupByLibrary.simpleMessage("Эффективность"),
        "efficiency_type": MessageLookupByLibrary.simpleMessage("Эффективный"),
        "empty_hint": MessageLookupByLibrary.simpleMessage("Пусто"),
        "enable": MessageLookupByLibrary.simpleMessage("Включить"),
        "end_enemy_turn": MessageLookupByLibrary.simpleMessage("Конец Хода Врага"),
        "enemy": MessageLookupByLibrary.simpleMessage("Враг"),
        "enemy_count": MessageLookupByLibrary.simpleMessage("Количество Врагов"),
        "enemy_list": MessageLookupByLibrary.simpleMessage("Враги"),
        "enemy_not_servant": MessageLookupByLibrary.simpleMessage("Не-Слуга"),
        "error_no_data_found": MessageLookupByLibrary.simpleMessage("Данные не найдены"),
        "error_no_internet": MessageLookupByLibrary.simpleMessage("Нет интернета"),
        "error_required_app_version": m1,
        "error_widget_hint": MessageLookupByLibrary.simpleMessage("Ошибка! Нажмите чтобы вернуться >_<"),
        "event_bonus": MessageLookupByLibrary.simpleMessage("Бонус"),
        "event_campaign": MessageLookupByLibrary.simpleMessage("Кампания"),
        "event_tower": MessageLookupByLibrary.simpleMessage("Башня"),
        "exchange_ticket_short": MessageLookupByLibrary.simpleMessage("Билет"),
        "faq": MessageLookupByLibrary.simpleMessage("FAQ"),
        "favorite": MessageLookupByLibrary.simpleMessage("Избранное"),
        "feedback_contact": MessageLookupByLibrary.simpleMessage("Контактная информация"),
        "feedback_content_hint": MessageLookupByLibrary.simpleMessage("Отзыв или предложение"),
        "feedback_form_alert": MessageLookupByLibrary.simpleMessage("Форма обратной связи не пуста, все равно выйти?"),
        "feedback_send": MessageLookupByLibrary.simpleMessage("Отправить"),
        "filename": MessageLookupByLibrary.simpleMessage("имя файла"),
        "filter": MessageLookupByLibrary.simpleMessage("Фильтр"),
        "filter_attribute": MessageLookupByLibrary.simpleMessage("Атрибут"),
        "filter_category": MessageLookupByLibrary.simpleMessage("Категория"),
        "filter_sort": MessageLookupByLibrary.simpleMessage("Сортировать"),
        "filter_sort_number": MessageLookupByLibrary.simpleMessage("№"),
        "filter_sort_rarity": MessageLookupByLibrary.simpleMessage("Редкость"),
        "fix_cors_for_chaldea_data_hint": MessageLookupByLibrary.simpleMessage("Обычно в FireFox"),
        "foukun": MessageLookupByLibrary.simpleMessage("Фоу"),
        "gallery_tab_name": MessageLookupByLibrary.simpleMessage("Дом"),
        "game_account": MessageLookupByLibrary.simpleMessage("Игровой аккаунт"),
        "game_experience": MessageLookupByLibrary.simpleMessage("Опыт"),
        "game_rewards": MessageLookupByLibrary.simpleMessage("Награды"),
        "game_server": MessageLookupByLibrary.simpleMessage("Игровой сервер"),
        "gamedata": MessageLookupByLibrary.simpleMessage("Игровые данные"),
        "gender": MessageLookupByLibrary.simpleMessage("Пол"),
        "general_all": MessageLookupByLibrary.simpleMessage("Все"),
        "general_default": MessageLookupByLibrary.simpleMessage("По умолчанию"),
        "general_export": MessageLookupByLibrary.simpleMessage("Экспорт"),
        "general_import": MessageLookupByLibrary.simpleMessage("Импорт"),
        "general_others": MessageLookupByLibrary.simpleMessage("Остальное"),
        "general_type": MessageLookupByLibrary.simpleMessage("Тип"),
        "gold": MessageLookupByLibrary.simpleMessage("Золото"),
        "grail": MessageLookupByLibrary.simpleMessage("Грааль"),
        "help": MessageLookupByLibrary.simpleMessage("Помощь"),
        "hide": MessageLookupByLibrary.simpleMessage("Скрыть"),
        "history": MessageLookupByLibrary.simpleMessage("История"),
        "ignore": MessageLookupByLibrary.simpleMessage("Игнорировать"),
        "illustrator": MessageLookupByLibrary.simpleMessage("Иллюстратор"),
        "image": MessageLookupByLibrary.simpleMessage("Изображение"),
        "import_csv_export_template": MessageLookupByLibrary.simpleMessage("Экспорт шаблона"),
        "import_csv_load_csv": MessageLookupByLibrary.simpleMessage("Загрузить CSV"),
        "import_csv_title": MessageLookupByLibrary.simpleMessage("Шаблон CSV"),
        "import_data": MessageLookupByLibrary.simpleMessage("Импорт"),
        "import_data_error": m4,
        "import_data_success": MessageLookupByLibrary.simpleMessage("Успешный импорт данных"),
        "import_from_clipboard": MessageLookupByLibrary.simpleMessage("Из буфера обмена"),
        "import_from_file": MessageLookupByLibrary.simpleMessage("Из файла"),
        "import_http_body_duplicated": MessageLookupByLibrary.simpleMessage("Скопировать"),
        "import_screenshot_hint": MessageLookupByLibrary.simpleMessage("Обновлять только распознанные результаты"),
        "import_source_file": MessageLookupByLibrary.simpleMessage("Импортировать Исходный Файл"),
        "import_userdata_more": MessageLookupByLibrary.simpleMessage("Дополнительные методы импорта"),
        "info_cv": MessageLookupByLibrary.simpleMessage("Актер Озвучки"),
        "info_luck": MessageLookupByLibrary.simpleMessage("Удача"),
        "info_mana": MessageLookupByLibrary.simpleMessage("Мана"),
        "info_strength": MessageLookupByLibrary.simpleMessage("Сила"),
        "install": MessageLookupByLibrary.simpleMessage("Установить"),
        "interlude": MessageLookupByLibrary.simpleMessage("Интерлюдия"),
        "item_apple": MessageLookupByLibrary.simpleMessage("Яблоко"),
        "item_grail2crystal": MessageLookupByLibrary.simpleMessage("Грааль → Лор"),
        "item_left": MessageLookupByLibrary.simpleMessage("Осталось"),
        "language": MessageLookupByLibrary.simpleMessage("Русский"),
        "language_en": MessageLookupByLibrary.simpleMessage("Russian"),
        "level": MessageLookupByLibrary.simpleMessage("Уровень"),
        "logic_type_and": MessageLookupByLibrary.simpleMessage("И"),
        "logic_type_or": MessageLookupByLibrary.simpleMessage("ИЛИ"),
        "login_change_name": MessageLookupByLibrary.simpleMessage("Изменить Имя"),
        "login_change_password": MessageLookupByLibrary.simpleMessage("Изменить пароль"),
        "login_confirm_password": MessageLookupByLibrary.simpleMessage("Подтвердить пароль"),
        "login_forget_pwd": MessageLookupByLibrary.simpleMessage("Не помню пароль"),
        "login_new_name": MessageLookupByLibrary.simpleMessage("Новое Имя"),
        "login_new_password": MessageLookupByLibrary.simpleMessage("Новый Пароль"),
        "login_password": MessageLookupByLibrary.simpleMessage("Пароль"),
        "login_signup": MessageLookupByLibrary.simpleMessage("Регистрация"),
        "login_username": MessageLookupByLibrary.simpleMessage("Имя пользователя"),
        "lucky_bag_best": MessageLookupByLibrary.simpleMessage("Лучшее"),
        "lucky_bag_rating": MessageLookupByLibrary.simpleMessage("Рейтинг"),
        "lucky_bag_worst": MessageLookupByLibrary.simpleMessage("Худшее"),
        "main_story_chapter": MessageLookupByLibrary.simpleMessage("Глава"),
        "map_show_roads": MessageLookupByLibrary.simpleMessage("Показать Дороги"),
        "my_room": MessageLookupByLibrary.simpleMessage("Моя Комната"),
        "name": MessageLookupByLibrary.simpleMessage("Имя"),
        "new_account": MessageLookupByLibrary.simpleMessage("Новый аккаунт"),
        "obtain_time": MessageLookupByLibrary.simpleMessage("Время"),
        "open": MessageLookupByLibrary.simpleMessage("Открыть"),
        "overview": MessageLookupByLibrary.simpleMessage("Обзор"),
        "plan": MessageLookupByLibrary.simpleMessage("План"),
        "plan_list_set_all_target": MessageLookupByLibrary.simpleMessage("Цель"),
        "plan_title": MessageLookupByLibrary.simpleMessage("План"),
        "progress": MessageLookupByLibrary.simpleMessage("Прогресс"),
        "quest": MessageLookupByLibrary.simpleMessage("Квест"),
        "quest_fields": MessageLookupByLibrary.simpleMessage("Поле"),
        "quest_reward_short": MessageLookupByLibrary.simpleMessage("Награда"),
        "quest_wave": MessageLookupByLibrary.simpleMessage("Волна"),
        "quit": MessageLookupByLibrary.simpleMessage("Уйти"),
        "random": MessageLookupByLibrary.simpleMessage("Рандом"),
        "rarity": MessageLookupByLibrary.simpleMessage("Редкость"),
        "rate_app_store": MessageLookupByLibrary.simpleMessage("Оценить в App Store"),
        "rate_play_store": MessageLookupByLibrary.simpleMessage("Оценить в Google Play"),
        "region_cn": MessageLookupByLibrary.simpleMessage("CN"),
        "region_jp": MessageLookupByLibrary.simpleMessage("JP"),
        "region_kr": MessageLookupByLibrary.simpleMessage("KR"),
        "region_na": MessageLookupByLibrary.simpleMessage("NA"),
        "region_notice": m9,
        "region_tw": MessageLookupByLibrary.simpleMessage("TW"),
        "rename": MessageLookupByLibrary.simpleMessage("Переименовать"),
        "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "save_as": MessageLookupByLibrary.simpleMessage("Сохранить как"),
        "save_to_photos": MessageLookupByLibrary.simpleMessage("Сохранить в Фото"),
        "saved": MessageLookupByLibrary.simpleMessage("Сохранено"),
        "screen_size": MessageLookupByLibrary.simpleMessage("Размер экрана"),
        "screenshots": MessageLookupByLibrary.simpleMessage("Скриншоты"),
        "select": MessageLookupByLibrary.simpleMessage("Выбрать"),
        "sent": MessageLookupByLibrary.simpleMessage("Отправить"),
        "servant": MessageLookupByLibrary.simpleMessage("Слуга"),
        "settings_data": MessageLookupByLibrary.simpleMessage("Данные"),
        "settings_documents": MessageLookupByLibrary.simpleMessage("Документация"),
        "settings_general": MessageLookupByLibrary.simpleMessage("Общие"),
        "settings_language": MessageLookupByLibrary.simpleMessage("Язык"),
        "settings_tab_name": MessageLookupByLibrary.simpleMessage("Настройки"),
        "share": MessageLookupByLibrary.simpleMessage("Поделиться"),
        "shop": MessageLookupByLibrary.simpleMessage("Магазины"),
        "show": MessageLookupByLibrary.simpleMessage("Показать"),
        "silver": MessageLookupByLibrary.simpleMessage("Серебро"),
        "simulator": MessageLookupByLibrary.simpleMessage("Симулятор"),
        "start": MessageLookupByLibrary.simpleMessage("Старт"),
        "success": MessageLookupByLibrary.simpleMessage("Успех"),
        "summon_ticket_short": MessageLookupByLibrary.simpleMessage("Билет"),
        "svt_basic_info": MessageLookupByLibrary.simpleMessage("Инфо"),
        "svt_class": MessageLookupByLibrary.simpleMessage("Класс"),
        "svt_fav_btn_remember": MessageLookupByLibrary.simpleMessage("Запомнить"),
        "svt_fav_btn_show_all": MessageLookupByLibrary.simpleMessage("Показать Все"),
        "svt_profile_n": m12,
        "switch_region": MessageLookupByLibrary.simpleMessage("Поменять Регион"),
        "target": MessageLookupByLibrary.simpleMessage("Цель"),
        "team_starting_member": MessageLookupByLibrary.simpleMessage("Передовая"),
        "test": MessageLookupByLibrary.simpleMessage("Тест"),
        "time": MessageLookupByLibrary.simpleMessage("Время"),
        "time_close": MessageLookupByLibrary.simpleMessage("Закрыть"),
        "time_end": MessageLookupByLibrary.simpleMessage("Конец"),
        "time_start": MessageLookupByLibrary.simpleMessage("Начать"),
        "toggle_dark_mode": MessageLookupByLibrary.simpleMessage("Переключить темный режим"),
        "unknown": MessageLookupByLibrary.simpleMessage("Неизвестно"),
        "unlock": MessageLookupByLibrary.simpleMessage("Разблокировать"),
        "unlock_quest": MessageLookupByLibrary.simpleMessage("Разблокировать Квест"),
        "update": MessageLookupByLibrary.simpleMessage("Обновить"),
        "update_already_latest": MessageLookupByLibrary.simpleMessage("Уже последняя версия"),
        "update_data_at_start": MessageLookupByLibrary.simpleMessage("Обновить при запуске"),
        "update_data_at_start_off_hint": MessageLookupByLibrary.simpleMessage(
            "Загрузка локальных данных с последующим фоновым обновлением, применение обновлений при следующем запуске"),
        "update_data_at_start_on_hint": MessageLookupByLibrary.simpleMessage("Запуск может занять больше времени"),
        "update_dataset": MessageLookupByLibrary.simpleMessage("Обновить набор данных"),
        "update_msg_error": MessageLookupByLibrary.simpleMessage("Не удалось обновить"),
        "update_msg_no_update": MessageLookupByLibrary.simpleMessage("Нет доступных обновлений"),
        "updated": MessageLookupByLibrary.simpleMessage("Обновлено"),
        "upload": MessageLookupByLibrary.simpleMessage("Загрузить"),
        "upload_and_close_app": MessageLookupByLibrary.simpleMessage("Загрузить и закрыть"),
        "upload_and_close_app_alert":
            MessageLookupByLibrary.simpleMessage("Загрузить данные перед закрытием приложения?"),
        "upload_before_close_app": MessageLookupByLibrary.simpleMessage("Загрузить перед закрытием"),
        "upload_not_eligible_hint":
            MessageLookupByLibrary.simpleMessage("Текущая команда не может быть загружена по следующим причинам:"),
        "upload_paused": m29,
        "usage": MessageLookupByLibrary.simpleMessage("Использование"),
        "userdata": MessageLookupByLibrary.simpleMessage("Пользовательские данные"),
        "userdata_download_backup": MessageLookupByLibrary.simpleMessage("Скачать резервную копию"),
        "userdata_download_choose_backup": MessageLookupByLibrary.simpleMessage("Выберать одну резервную копию"),
        "userdata_local": MessageLookupByLibrary.simpleMessage("Пользовательские данные (Локально)"),
        "userdata_sync_hint":
            MessageLookupByLibrary.simpleMessage("Обновляются только данные учетной записи, без локальных настроек"),
        "userdata_sync_server": MessageLookupByLibrary.simpleMessage("Синхронизация данных (Сервер)"),
        "userdata_upload_backup": MessageLookupByLibrary.simpleMessage("Загрузить резервную копию"),
        "version": MessageLookupByLibrary.simpleMessage("Версия"),
        "video": MessageLookupByLibrary.simpleMessage("Видео"),
        "view_illustration": MessageLookupByLibrary.simpleMessage("Посмотреть иллюстрацию"),
        "voice": MessageLookupByLibrary.simpleMessage("Голос"),
        "war": MessageLookupByLibrary.simpleMessage("Война"),
        "war_age": MessageLookupByLibrary.simpleMessage("Эпоха"),
        "war_map": MessageLookupByLibrary.simpleMessage("Карта"),
        "warning": MessageLookupByLibrary.simpleMessage("Предупреждение"),
        "web_domain_choice_hint": MessageLookupByLibrary.simpleMessage(
            "Конечная точка CN для материкового Китая\nВеб-приложение рекомендуется только для пользователей ПК, мобильный сайт работает медленно и может неожиданно обновляться."),
        "words_separate": m13
      };
}
