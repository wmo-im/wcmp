# =================================================================
#
# Authors: Tom Kralidis <tomkralidis@gmail.com>
#
# Copyright (c) 2020 Tom Kralidis
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# =================================================================

import csv
import glob
import os
from xml.dom import minidom

from jinja2 import Environment, FileSystemLoader

AMENDMENTS = {
    # codelist name, row at which amendments start
    'CI_DateTypeCode': 4,
    'MD_KeywordTypeCode': 5
}

DATA = {}

TEMPLATE_ENV = Environment(
    loader=FileSystemLoader(['scripts']),
    autoescape=True
)
TEMPLATE = TEMPLATE_ENV.get_template('wmo-codelist-catalogue.xml.j2')

for cl in glob.glob('codelists/*.csv'):
    file_basename = os.path.splitext(os.path.basename(cl))[0]

    DATA[file_basename] = []

    with open(cl) as csvfile:
        reader = csv.DictReader(csvfile)
        for idx, row in enumerate(reader):
            row2 = row
            if (file_basename in AMENDMENTS.keys() and
                    idx >= AMENDMENTS[file_basename]):
                row2['type'] = 'new'
            elif file_basename.startswith('WMO'):
                row2['type'] = 'new'
            else:
                row2['type'] = 'existing'
            DATA[file_basename].append(row2)

xml = TEMPLATE.render(data=DATA)
val = minidom.parseString(xml)
print('\n'.join([val for val in val.toprettyxml(indent=' '*2).split('\n') if val.strip()]))  # noqa
