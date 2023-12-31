
function check_python_packages()
    checked_package_names = ["psycopg2", "sqlalchemy", "eventregistry", "apscheduler"]
    py"""
    import sys
    def req(checked_package_names):    
        return [p not in sys.modules for p in checked_package_names]
    """
    required = py"req"(checked_package_names)
    Conda.pip_interop(true)#, Conda.PYTHONDIR[1:end-4] )
    for req_package in checked_package_names[required]
        println("installing:  ", req_package)
        Conda.pip("install",req_package)#, Conda.PYTHONDIR[1:end-4])
    end
    return nothing
end
