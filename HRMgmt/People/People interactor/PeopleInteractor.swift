
class PeopleInteractor: PeopleInputInteractorProtocol {
    func getSearchedList(search: String) {
        let people  = fetchSearchedList(search: search)
        presenter?.updatedList(peopleDetails: people)
    }
    
    var presenter: PeopleOutputInteractorProtocol?
    let db = DatabaseController()
    func getCompleteList() {
        let people  = fetchCompleteList()
        presenter?.updatedList(peopleDetails: people)
    }
    
    func getDeptUuid(empUuid: String) {
        let deptUuid = fetchDeptUuid(empUuid: empUuid)
        presenter?.updatedDeptUuid(deptUuid: deptUuid)
    }
    
    func getDepartmentList(deptUuid: String) {
        let people = fetchDeptList(deptUuid: deptUuid)
        presenter?.updatedList(peopleDetails: people)
    }
    
    private func fetchCompleteList() -> [People] {
        let people = db.getPeopleList()
        return people
    }
    
    private func fetchDeptUuid(empUuid : String) -> String{
        let empUuid = db.getDeptUuid(empUuid: empUuid)
        return empUuid
    }
    
    private func fetchDeptList(deptUuid : String) -> [People] {
        let empList = db.getDepartmentList(deptUuid: deptUuid)
        return empList
    }
    
    private func fetchSearchedList(search : String) -> [People] {
        let empList = db.getSearchedList(search: search)
        return empList
    }
    

}
