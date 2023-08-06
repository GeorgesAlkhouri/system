{
  enable = true;

  settings = {
    client = {
      dark_mode = false;
      max_status_lines = null;
      read_local_logs = true;
      restart_in_place = false;
      show_confirmation_questions = false;
      show_expanded_aliases = false;
      status_datetime_format = "%Y-%m-%d %H:%M:%S";
      status_time_format = "%H:%M:%S";
    };

    daemon = {
      callback = null;
      callback_log_lines = 10;
      pause_all_on_failure = false;
      pause_group_on_failure = false;
      default_parallel_tasks = 2;
    };

    shared = {
      daemon_cert = null;
      daemon_key = null;
      host = "127.0.0.1";
      pid_path = null;
      port = "6924";
      pueue_directory = null;
      runtime_directory = null;
      shared_secret_path = null;
      unix_socket_path = null;
      use_unix_socket = false;
    };
  };
}
