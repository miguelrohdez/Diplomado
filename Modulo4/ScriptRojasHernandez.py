#Rojas Hernandez Miguel Alejandro
#Python v3.7
def main():
    try:
        archivo = open("datos.txt","r")
        archivoNuevo = open("exec.sql","w")
        try:
            for linea in archivo:
                if linea[-1] == '\n':
                    linea = linea[:-1]
                registroSep = []
                registroSep.append(linea.split('|'))
                archivoNuevo.write('EXEC SP_AltaEmpleado ')
                for palabra in registroSep:
                    aux1 = str(palabra).replace('[','')
                    aux2 = aux1.replace(']','')
                    #print(aux2)
                    archivoNuevo.writelines(aux2)
                archivoNuevo.write(";\n")
        finally:
            print('\tLISTO!!\nScript "exec.sql" generado corretactamente')
            archivo.close()
    except FileNotFoundError:
        print("No se pudo abrir el archivo")

if __name__ == '__main__':
    main()
