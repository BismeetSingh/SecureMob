import json

def generate_commands(input_string, commands_json):
    commands_list = input_string.split(',')

    output = {}
    for command in commands_list:
        command = command.strip()
        for category, category_commands in commands_json.items():
            if command in category_commands:
                output[command] = category_commands[command]

    return output

if __name__ == "__main__":
    input_string = "InstallPackageLocally,InstallPackagesFromPackageJson,RunScriptFromPackageJson"
    
    json_data = '''
    {
      "npmCommands": {
        "InitializeNewProject": "npm init",
        "InstallPackageLocally": "npm install <package-name>",
        "InstallPackageGlobally": "npm install -g <package-name>",
        "InstallPackagesFromPackageJson": "npm install",
        "StartNodeApplication": "npm start",
        "RunScriptFromPackageJson": "npm run <script-name>",
        "UpdatePackageToLatestVersion": "npm update <package-name>",
        "ListInstalledPackages": "npm ls",
        "RemovePackage": "npm uninstall <package-name>",
        "SearchForPackages": "npm search <keyword>"
      },
      "yarnCommands": {
        "InitializeNewProject": "yarn init",
        "InstallPackageLocally": "yarn add <package-name>",
        "InstallPackageGlobally": "yarn global add <package-name>",
        "InstallPackagesFromPackageJson": "yarn install",
        "StartNodeApplication": "yarn start",
        "RunScriptFromPackageJson": "yarn run <script-name>",
        "UpdatePackageToLatestVersion": "yarn upgrade <package-name>",
        "ListInstalledPackages": "yarn list",
        "RemovePackage": "yarn remove <package-name>",
        "SearchForPackages": "yarn search <keyword>"
      },
      "pm2Commands": {
        "StartNodeApplication": "pm2 start <app.js>",
        "ListRunningProcesses": "pm2 list",
        "StopProcess": "pm2 stop <app-name or app-id>",
        "RestartProcess": "pm2 restart <app-name or app-id>",
        "MonitorCPUMemoryUsage": "pm2 monit",
        "ViewLogsForProcess": "pm2 logs <app-name or app-id>",
        "ReloadProcessesAfterCodeChanges": "pm2 reload <app-name or app-id>",
        "DeleteProcessFromPm2": "pm2 delete <app-name or app-id>"
      },
      "linuxCommands": {
        "NavigateToDirectory": "cd <directory-path>",
        "ListFilesInDirectory": "ls",
        "CopyFilesOrDirectories": "cp <source> <destination>",
        "MoveOrRenameFiles": "mv <source> <destination>",
        "RemoveFilesOrDirectories": "rm <file or directory>",
        "CreateNewDirectory": "mkdir <directory-name>",
        "PrintWorkingDirectory": "pwd",
        "ShowContentOfFile": "cat <file-name>",
        "SSHIntoRemoteServer": "ssh user@hostname",
        "UpdatePackageRepositories": "sudo apt update"
      }
    }
    '''

    commands_json = json.loads(json_data)

    result = generate_commands(input_string, commands_json)
    print(json.dumps(result, indent=2))
