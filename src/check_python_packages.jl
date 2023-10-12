
function check_python_packages()
    checked_package_names = ["psycopg2", "sqlalchemy", "eventregistry"]
    py"""
    import sys
    def req(checked_package_names):    
        return [p in sys.modules for p in checked_package_names]
    """
    required = py"req"(checked_package_names)
    Conda.pip_interop(true) 
    for req_package in checked_package_names[required]
        println("installing:  ", req_package)
        Conda.pip.("install", req_package)
    end
    return nothing
end

check_python_packages()

