import ranger.api
import ranger.core.linemode

import os.path
from ranger.ext import spawn

@ranger.api.register_linemode     # It may be used as a decorator too!
class MyLinemode(ranger.core.linemode.LinemodeBase):
    name = "diffurcate_linemode"

    def filetitle(self, file, metadata):
        return file.relative_path

    def infostring(self, file, metadata):
        if file.extension == 'diff' and os.path.exists(file.path):
            try:
                pluslines = spawn.spawn(["grep", "-c", "^+ ", file.path]).strip()
            except Exception as e:
                pluslines = '0'
            try:
                minuslines = spawn.spawn(["grep", "-c", "^- ", file.path]).strip()
            except Exception as e:
                minuslines = '0'
            return '+' + pluslines + ' -' + minuslines
        if file.is_directory and os.path.exists(file.path):
            try:
                pluslines = spawn.spawn(["grep", "-hR", "-c", "^+ ", "--include=*.diff", file.path]).strip().split('\n')
                totalpluslines=str(sum(map(lambda x: int(x), pluslines)))
            except Exception as e:
                totalpluslines='0'
            try:
                minuslines = spawn.spawn(["grep", "-hR", "-c", "^- ", "--include=*.diff", file.path]).strip().split('\n')
                totalminuslines=str(sum(map(lambda x: int(x), minuslines)))
            except Exception as e:
                totalminuslines='0'
            return '+' + totalpluslines + ' -' + totalminuslines
        return
