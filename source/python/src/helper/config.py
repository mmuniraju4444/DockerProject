from configparser import ConfigParser
import os

def read_config(data=''):
    """
    :param data: string format : filename.section | filename.section.label
    :return: array | string
    """
    if not data:
        raise Exception('Empty string passed')
    # Create Parser and read ini configuration file
    parser = ConfigParser()
    split_data = data.split(".")
    if len(split_data) < 2:
        raise Exception('Not valid data string')
    #return split_data
    #elif len(split_data) == 2:
    file_name = split_data[0]
    section_name = split_data[1]
    # else:
    #     file_name = split_data[0]
    #     section_name = split_data[1]
    #     label_name = split_data[2]
    parser.read(os.path.join(os.path.abspath(os.path.dirname(__file__)),'..', 'config', file_name+'.ini'))
    config_data = {}

    if parser.has_section(section_name):
        section_data = parser.items(section_name)
        for section in section_data:
            config_data[section[0]] = section[1]
    else:
        raise Exception('{0} Not Found In the {1} file',format(section_name,file_name))

    return config_data

