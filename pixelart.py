from __future__ import print_function
import pickle
import os.path
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request

# If modifying these scopes, delete the file token.pickle.
SCOPES = ['https://www.googleapis.com/auth/spreadsheets.readonly']

# The ID and range of a sample spreadsheet.
SAMPLE_SPREADSHEET_ID = '1oMlUD3Uh-KbRUm3C9YE-rAJ4X-k-3GcclEo42aT0wLE'

def main():
    """Shows basic usage of the Sheets API.
    Prints values from a sample spreadsheet.
    """
    creds = None
    # The file token.pickle stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    if os.path.exists('token.pickle'):
        with open('token.pickle', 'rb') as token:
            creds = pickle.load(token)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file('/Users/spierce/.ssh/pixelart-credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open('token.pickle', 'wb') as token:
            pickle.dump(creds, token)

    service = build('sheets', 'v4', credentials=creds)

    spreadsheets = service.spreadsheets()

    workbook = spreadsheets.get(spreadsheetId=SAMPLE_SPREADSHEET_ID).execute()

    for sheet in workbook['sheets']:
        result = spreadsheets.values().get(spreadsheetId=SAMPLE_SPREADSHEET_ID, range=f"{sheet['properties']['title']}").execute()
        title = sheet['properties']['title']
        values = result.get('values', [])
        if title == 'template' or not values:
            continue

        print(f'compiling {title}')
        with open(f'data/uberop/functions/pixels/{title}.mcfunction', 'w') as f:
            f.write(render(title, values))

DECODER = {
    'm': 'stripped_crimson_stem',
    'r': 'red_concrete',
    'o': 'orange_concrete',
    'o2': 'orange_terracotta',
    'y': 'yellow_concrete',
    'g': 'green_concrete',
    'c': 'cyan_concrete',
    'b': 'light_blue_concrete',
    'b2': 'blue_concrete',
    'p': 'purple_concrete',
    'pk': 'pink_concrete',
    'bk': 'black_concrete',
    'gy': 'light_gray_concrete',
    'w': 'white_concrete',
    't': 'stripped_birch_log'
}

def render(title, values):
    # remove color palette column
    last_column = len(values[0])
    values.reverse()
    lines = []
    for y, row in enumerate(values):
        for x, v in enumerate(row[0:last_column - 1]):
            if v:
                lines.append(f'setblock ^{x} ^{y} ^ {DECODER[v]}')
            print('|'.join(str(v).rjust(2, ' ')), end='')
        print('')
    return '\n'.join(lines)


if __name__ == '__main__':
    main()
