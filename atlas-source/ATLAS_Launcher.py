"""ATLAS PyInstaller launcher with diagnostics and correct bundle location."""
from pathlib import Path
import os
import sys
import traceback
import datetime

bundle = Path(getattr(sys, '_MEIPASS', Path(__file__).resolve().parent))
log_dir = Path.home() / 'ATLAS-Darkstar'
log_dir.mkdir(parents=True, exist_ok=True)
log_file = log_dir / 'startup.log'

try:
    os.chdir(bundle)
    sys.path.insert(0, str(bundle))
    with log_file.open('a', encoding='utf-8') as log:
        log.write(f'\n=== ATLAS start {datetime.datetime.now().isoformat()} ===\n')
        log.write(f'Executable: {sys.executable}\nBundle: {bundle}\n')
    import server  # Static import ensures PyInstaller bundles Python standard-library dependencies.
    server.main()
except BaseException:
    with log_file.open('a', encoding='utf-8') as log:
        traceback.print_exc(file=log)
    print('ATLAS could not start. Error details saved to:', log_file, flush=True)
    traceback.print_exc()
    if sys.stdin and sys.stdin.isatty():
        input('Press Enter to close this window...')
    raise
