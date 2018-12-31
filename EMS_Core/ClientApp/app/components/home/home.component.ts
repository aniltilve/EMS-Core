import { Component } from '@angular/core';

@Component({
    selector: 'home',
    templateUrl: './home.component.html',
    styleUrls: ['./home.component.css']
})
export class HomeComponent {
    public agencyExists: boolean;
    public userExists: boolean;

    constructor() {
        this.agencyExists = true;
        this.userExists = true;
    }

    validate() {
        //this.agencyExists = false;
    }

    reset(event: any) {
        switch (event.target.id) {
            case "agency": {
                this.agencyExists = true;
                break;
            }
        }
    }
}
